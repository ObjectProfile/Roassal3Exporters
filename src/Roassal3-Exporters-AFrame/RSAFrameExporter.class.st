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
		'dictionary',
		'shouldRenderAR',
		'shouldRenderQR'
	],
	#category : #'Roassal3-Exporters-AFrame'
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
	shouldRenderFloor := false.
	shouldRenderAR := false.
	shouldRenderQR := false.
	scale := 0.006.
	scale := scale @ scale negated.
	translation := 0@ 0.

]

{ #category : #'public - configuration' }
RSAFrameExporter >> noFloor [
	"Do not have a floor"
	shouldRenderFloor := false
]

{ #category : #public }
RSAFrameExporter >> runInZinc [
	ZnServer startDefaultOn: 8080.
	ZnServer default logToTranscript.
	ZnServer default delegate map: #aFrame to: self.
]

{ #category : #accesing }
RSAFrameExporter >> stream [
	^ stream
]

{ #category : #accessing }
RSAFrameExporter >> stream: aWriteStream [ 
	stream := aWriteStream
]

{ #category : #public }
RSAFrameExporter >> value: request [
  ^ self handleRequest: request
]

{ #category : #visiting }
RSAFrameExporter >> visitBoundingShape: aShape [
	aShape printOnAFrame: self.

]

{ #category : #visiting }
RSAFrameExporter >> visitCamera [ 
	shouldRenderQR
		ifTrue: [ self write: '<a-marker-camera preset="hiro"' ]
		ifFalse: [ self write: '<a-camera ' ].
	stream
		<< 'position="0 1.6 4">';
		<< '<a-entity id="idPopUP" ';
		<< 'visible="false" position=" '.
	shouldRenderQR | shouldRenderAR 
		ifTrue: [ self write: '0.1 -0.2 -2"' ]
		ifFalse: [ self write: '1.5 0.4 -2"' ].
	stream
		<< 'material="color: #333"></a-entity> ';
		<< '<a-cursor></a-cursor>'.
	shouldRenderQR
		ifTrue: [ self write: '</a-marker-camera>' ]
		ifFalse: [ self write: '</a-camera>' ].
	stream crlf.
]

{ #category : #visiting }
RSAFrameExporter >> visitCanvas: aRSCanvas [
	| rec |
	scale := 0.006.
	scale := scale @ scale negated.
	rec := aRSCanvas encompassingRectangle.
	translation := (rec floatCenter negated * scale) + (0@rec height negated * scale).
	aRSCanvas shapes
		do: [ :shape | shape accept: self ]
		separatedBy: [ stream crlf ]
]

{ #category : #visiting }
RSAFrameExporter >> visitLabel: aRSLabel [
	aRSLabel printOnAFrame: self.


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

{ #category : #writing }
RSAFrameExporter >> write3DPoint: aPoint [ 
	| p |
	p := aPoint * scale + translation.
	stream
		<< p x asString; space;
		<< p y asString;
		<< ' 0'.
]

{ #category : #writing }
RSAFrameExporter >> write: aString [
	stream nextPutAll: (aString replaceAll: String cr with: String crlf)
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
<meta charset="utf-8">
<title>'.
	self write: title.
	self write: '</title>
<meta name="description" content="Roassal canvas exported">
<script src="https://aframe.io/releases/1.0.4/aframe.min.js"></script>
<script src="https://unpkg.com/aframe-event-set-component@3.0.3/dist/aframe-event-set-component.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>'.
	shouldRenderFloor ifFalse: [ 
		self write: '
<script src="https://jeromeetienne.github.io/AR.js/aframe/build/aframe-ar.js"></script>
' ].
	self write: '
<script>
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
			console.log(totalWidth);
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
			console.log(txtInfo);
			aTextPopUP.setAttribute(''visible'', true);
		  }
		});
		
      el.addEventListener(''mouseleave'', function () {
        el.setAttribute(''color'', defaultColor);
		  aTextPopUP.setAttribute(''visible'', false);
      });
    }
  });
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
RSAFrameExporter >> writeShapes [

	self write: '
<a-scene '.
	shouldRenderAR | shouldRenderQR 
		ifTrue:  [ self write: 'embedded arjs ' ]
		
		ifFalse: [ self write: 'background="color: #fff" ' ].

self write: 'stats>'.

	shouldRenderFloor ifTrue: [ 
		self write: '<a-assets>
<a-image id="floor" src="'.
		self write: self floorImg.
		self write: '"></a-image>
</a-assets>
			<a-entity geometry="primitive: cylinder; height: .2; radius: 12;" material="color: #BABABA; src: #floor; metalness: .2; repeat: 50 20; roughness: .1" position="0 0 0"></a-entity>
' ].
	self visitCamera. 
	canvas accept: self.
	self write: '
</a-scene>
'
]

{ #category : #writing }
RSAFrameExporter >> writeToStream: aStream [
	stream := aStream.
	self writeHMTL.
	stream := nil.
]
