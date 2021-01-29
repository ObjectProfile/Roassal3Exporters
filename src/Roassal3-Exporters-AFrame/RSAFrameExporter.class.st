"
This exporter uses aframe javascript library to render a 3d scene in the web browser.
"
Class {
	#name : #RSAFrameExporter,
	#superclass : #RSHTMLExporter,
	#instVars : [
		'stream',
		'scale',
		'translation',
		'shouldRenderFloor',
		'shouldRenderAR',
		'shouldRenderQR',
		'shouldRunInZinc',
		'matrix',
		'depthSize',
		'level'
	],
	#category : #'Roassal3-Exporters-AFrame-Exporter'
}

{ #category : #accessing }
RSAFrameExporter >> angleFor: aShape [
	| m a b |
	m := aShape matrix.
	a := m transform: 0@0.
	b := m transform: 1@0.
	^ (b-a) angle negated radiansToDegrees
]

{ #category : #accessing }
RSAFrameExporter >> depthSize [
	^depthSize.
]

{ #category : #accessing }
RSAFrameExporter >> depthSize: aNumber [
	depthSize := aNumber.
]

{ #category : #accessing }
RSAFrameExporter >> exportAndOpen [
	WebBrowser openOn: self export asFileReference asUrl asString
]

{ #category : #public }
RSAFrameExporter >> exportToFile: file [
	file writeStreamDo: [ :s | self writeToStream: s ]. 
]

{ #category : #accessing }
RSAFrameExporter >> floorImg [
	^ 'https://i.imgur.com/dckg70j.jpg'
]

{ #category : #initialization }
RSAFrameExporter >> initialize [
	super initialize.
	shouldRenderFloor := true.
	shouldRenderAR := false.
	shouldRenderQR := false.
	shouldRunInZinc := false.
	scale := 0.006.
	scale := scale @ scale negated.
	translation := 0@ 0.
	matrix := AthensAffineTransform new.
	self depthSize: 0.003.
	self level: 0.
	

]

{ #category : #accessing }
RSAFrameExporter >> level [

	^ level
]

{ #category : #accessing }
RSAFrameExporter >> level: anObject [

	level := anObject
]

{ #category : #accessing }
RSAFrameExporter >> matrix [
	^matrix
]

{ #category : #'public - configuration' }
RSAFrameExporter >> noFloor [
	"Do not have a floor"
	shouldRenderFloor := false
]

{ #category : #helper }
RSAFrameExporter >> restoreLevelAfter: aBlock [
	self level: self level +1.
	aBlock value.
	self level: self level -1.
]

{ #category : #accessing }
RSAFrameExporter >> sendInfoToZinc [

	^ '
	var startSession= new Date();
	var parser = new UAParser();
	var result = parser.getResult();
	var bow = bowser.name+'' ''+bowser.version;
	var os = result.os;
	function monitorEvents(document) {
		var documentsEvents = [ ];
		var log = function(e) { events.push(e);};
		for(var i in document) {
			if(i.startsWith("on")) documentsEvents.push(i.substr(2));
		}
		documentsEvents.forEach(function(eventName) {
			document.addEventListener(eventName, log, true);
		});
	}	
	$(document).ready(function(callback) {
		monitorEvents(document);
		window.onbeforeunload = function(){
			events = JSON.parse(JSON.stringify(events, [''type'',''timeStamp'']));
			var endSession = new Date();
			var resultSession = (endSession.getTime() - startSession.getTime()); //time in milliseconds
			var data = {"data": {  "os": os, "browser": bow, "startSession": startSession, "timeSession": resultSession, "infoPopUP": popUp, "events": events} };
			return $.ajax({
				type: ''POST'',
				url: ''aFrameLog'',
				async : true,
				data: JSON.stringify(data),
				dataType: ''json'',
				contentType: "application/json; charset=utf-8",
				success: function(result) {
					console.log(result);	
					callback(events, popUp, resultsession, nav, bow, os);		
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
				}
			})
		}
	});
'
]

{ #category : #accessing }
RSAFrameExporter >> stream [
	^ stream
]

{ #category : #accessing }
RSAFrameExporter >> stream: aWriteStream [ 
	stream := aWriteStream
]

{ #category : #accessing }
RSAFrameExporter >> translation [
	^ translation
]

{ #category : #public }
RSAFrameExporter >> validTextFor: aString [
	^aString copyReplaceAll: '"' with: '\"'.
	
	
]

{ #category : #visiting }
RSAFrameExporter >> visitBoundingShape: aShape [
	matrix restoreAfter: [ 
		matrix multiplyBy: aShape matrix. 
		aShape color ifNotNil: [ aShape printOnAFrame: self ].
		aShape hasBorder ifTrue: [ aShape printBorderOnAFrame: self ].
		aShape hasChildren ifTrue: [ 
			self restoreLevelAfter: [ 
				aShape children do: [ :child | 
					stream crlf.
					child accept: self  ]
			]
		]
	].

]

{ #category : #visiting }
RSAFrameExporter >> visitCamera [ 
	shouldRenderQR
		ifTrue: [ self write: '<a-marker-camera preset=''hiro''' ]
		ifFalse: [ self write: '<a-camera ' ].
	stream
		<< 'position=''0 1.6 4''>';
		<< '<a-entity id=''idPopUP'' ';
		<< 'visible=''false'' position='' ';
		<< '0 -0.2 -2''';
		<< 'material=''color: #333''></a-entity> ';
		<< '<a-cursor></a-cursor>'.
	shouldRenderQR
		ifTrue: [ self write: '</a-marker-camera>' ]
		ifFalse: [ self write: '</a-camera>' ].
	stream crlf.
]

{ #category : #visiting }
RSAFrameExporter >> visitCanvas: aRSCanvas [
	| rec |
	rec := aRSCanvas encompassingRectangle.
	translation := (rec floatCenter negated * scale) + (0@rec height negated * scale).
	aRSCanvas shapes
		do: [ :shape | shape accept: self ]
		separatedBy: [ stream crlf ]
]

{ #category : #visiting }
RSAFrameExporter >> visitLabel: aRSLabel [
	self visitBoundingShape: aRSLabel.


]

{ #category : #visiting }
RSAFrameExporter >> visitLine: aRSLine [
	aRSLine printOnAFrame: self.

]

{ #category : #'public - configuration' }
RSAFrameExporter >> withAR [
	"with AR"
	shouldRenderAR := true.
	shouldRenderFloor := false.
]

{ #category : #'public - configuration' }
RSAFrameExporter >> withFloor [
	"Do not have a floor"
	shouldRenderFloor := true
]

{ #category : #'public - configuration' }
RSAFrameExporter >> withQR [
	"with QR presset hiro Image"
	shouldRenderQR := true.
	shouldRenderFloor := false.
]

{ #category : #public }
RSAFrameExporter >> withRunInZinc [
	shouldRunInZinc := true.

]

{ #category : #writing }
RSAFrameExporter >> write3DPoint: aPoint [ 
	| p |
	p := aPoint * scale + translation.
	stream
		<< p x asFloat asString; space;
		<< p y asFloat asString; space;
		<< (self level * self depthSize ) asString.
]

{ #category : #writing }
RSAFrameExporter >> write: aString [
	stream nextPutAll: (aString copyReplaceAll: String cr with: String crlf)
]

{ #category : #writing }
RSAFrameExporter >> writeHMTL [

	| title |
	title := canvas
		         propertyAt: #title
		         ifAbsent: [ 'Roassal with AFrame' ].
	self write: '<!DOCTYPE html>
<html>
	<head>
	<meta charset=''utf-8''>
	<title>'.
	self write: title.
	self write: '</title>
	<meta name=''description'' content=''Roassal canvas exported''>
	<script src=''https://aframe.io/releases/1.0.4/aframe.min.js''></script>
	<script src=''https://unpkg.com/aframe-event-set-component@3.0.3/dist/aframe-event-set-component.	min.js''></script>
	<script src=''https://unpkg.com/aframe-extras@3.3.0/dist/aframe-extras.min.js''></script>
	<script src=''https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js''></script>'.
	shouldRunInZinc ifTrue: [ 
		self write: self writeScriptToInfo ].
	shouldRenderAR ifTrue: [ 
		self write: '
	<script src=''https://jeromeetienne.github.io/AR.js/aframe/build/aframe-ar.js''></script>
' ].
	self write: '<script>'.
	self write: self writeScript.
	shouldRunInZinc ifTrue: [ self write: self sendInfoToZinc ].
	self write:'
</script>
</head>
<body>
'.
	self writeShapes.
	self write: '
</body>
</html>
'
]

{ #category : #writing }
RSAFrameExporter >> writeScript [
	^'
	var popUp = [ ];
	var popInfo = '''';
	var dateStart;
	var dateFinal;
	var dateResult = 0;
	var events = [ ];
	AFRAME.registerComponent(''change-color-on-hover'', {
		schema: {
			color:{
				default: ''1F77B4''
			}
		},
		init: function () {
			var data = this.data;
	      var el = this.el;  // <a-box>
	      var defaultColor = el.getAttribute(''material'').color;
			var aTextPopUP = document.querySelector(''#idPopUP'');
			el.addEventListener(''mouseenter'', function () {
				el.setAttribute(''color'', data.color);
				var txtInfo = el.getAttribute(''model'');
				if (txtInfo != null) {
					var value = ''value: '' + txtInfo + ''; color: #FFF; anchor: center; align: center; width: 1.2'';
					totalWidth = Math.trunc(txtInfo.length / 10);
					switch (totalWidth) {
						case 0:
							var width = 0.4;
							var height = 0.15;
							break;
						case 1:
							var width = 0.7;
							var height = 0.15;
							break;
						case 2:
							var width = 1;
							var height = 0.15;
							break;
						case totalWidth > 2:
							var width = ''auto'';
							var height = ''auto'';
							break;
					}
					var geometry = ''primitive: plane; height: ''+ height + ''; width: '' + width;
					aTextPopUP.setAttribute(''geometry'', geometry);
					aTextPopUP.setAttribute(''text'', value);
					aTextPopUP.setAttribute(''visible'', true);
					var date = new Date();
					popInfo = txtInfo;
					dateStart = date.getMilliseconds();
			 	}
			});
			el.addEventListener(''mouseleave'', function () {
				el.setAttribute(''color'', defaultColor);
				aTextPopUP.setAttribute(''visible'', false);
				var date = new Date;
				dateFinal = date.getMilliseconds();
				popUp.push({''model'': popInfo,''timeStart'': dateStart, ''timeFinal'': dateFinal});
	      });
		}
	});'.

]

{ #category : #accessing }
RSAFrameExporter >> writeScriptToInfo [
	^'
	<script src=''https://cdnjs.cloudflare.com/ajax/libs/bowser/1.9.4/bowser.min.js''></script>
	<script src=''https://cdn.jsdelivr.net/npm/ua-parser-js@0/dist/ua-parser.min.js''></script>'
]

{ #category : #writing }
RSAFrameExporter >> writeShapes [

	self write: '
<a-scene '.
	shouldRenderAR | shouldRenderQR
		ifTrue: [ self write: 'embedded arjs ' ]
		
		ifFalse: [ self write: 'background=''color: #fff'' ' ].
		
	self write: 'stats>'.
	
	shouldRenderFloor ifTrue: [ 
		self write: '
<a-assets>
	<a-image id=''floor'' src='''.
		self write: self floorImg.
		self write: '''></a-image>
</a-assets>
<a-entity geometry=''primitive: cylinder; height: .2; radius: 12;'' material=''color: #BABABA; src: #floor; metalness: .2; repeat: 50 20; roughness: .1'' position=''0 0 0''></a-entity>
' ].
	self visitCamera.
	canvas accept: self.
	self write: '
</a-scene>'
]

{ #category : #writing }
RSAFrameExporter >> writeSolidBox: box [
	| extent color |
	extent := box extent * scale abs.
	color := box color.
	color ifNil: [ ^ self ].
	stream << '<a-box '. 
	box model ifNotNil: [ stream <<'model='''; << ( self validTextFor: box model asString); <<'''' ].
	stream <<'position='''.
	self write3DPoint: matrix translation.
	stream 
		<< ''' width='' ';
		<< extent x asString; space; 
		<< ''' height='' ';
		<< extent y asString; 
		<< ''' depth='' ';
		<< self depthSize asString ;
		<< ''' color= ''#';
		<< color asHexString;
		<< ''' change-color-on-hover=''color: #';
		<< color muchLighter asHexString;
		<< ''' roughness='' 1.0'' metalness='' 0.2'' ></a-box>'.
]

{ #category : #writing }
RSAFrameExporter >> writeToStream: aStream [
	stream := aStream.
	self writeHMTL.
	stream := nil.
]
