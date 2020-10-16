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
		'dictionary'
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
	scale := 0.006.
	scale := scale @ scale negated.
	translation := 0@ 0.5.
	shouldRenderFloor := true.
]

{ #category : #'public - configuration' }
RSAFrameExporter >> noFloor [
	"Do not have a floor"
	shouldRenderFloor := false
]

{ #category : #visiting }
RSAFrameExporter >> visitBoundingShape: aShape [
	| color extent |
	extent := aShape extent * scale abs.
	color := aShape color.
	color ifNil: [ ^ self ].
	stream << '<a-box position="'.
	self write3DPoint: aShape position.
	stream 
		<< '" width=" ';
		<< extent x asString; space; 
		<< '" height=" ';
		<< extent y asString; 
		<< '" depth=" ';
		<< (extent x min: extent y) asString;
		<< '" color= "#';
		<< color asHexString;
		<< '" change-color-on-hover="color: #';
		<< color muchLighter asHexString;
		<< '" roughness=" 1.0" metalness=" 0.2" event-set__enter="_event: mouseenter;  _target:'; 		
		<< '#idPopUP; visible: true;"';
		<< ' event-set__leave="_event: mouseleave;  _target: #idPopUP; visible: false;';
		<<'" ></a-box>'.
]

{ #category : #visiting }
RSAFrameExporter >> visitCanvas: aRSCanvas [ 
	stream << '<a-camera position="0 1.6 4">';
			 << '<a-text id="idPopUP" ';
			 << ' align="center" width="2.5" color="#FFF"';
			 << 'visible="false" position="2 2 -4" geometry="primitive: plane; width: 1.75"'; 			 			 			 << 'material="color: #333"></a-text> ';
			 << '<a-cursor></a-cursor></a-camera>'; crlf.
	aRSCanvas shapes do: [ :shape | shape accept: self ] separatedBy: [ stream crlf ].
]

{ #category : #visiting }
RSAFrameExporter >> visitLabel: aRSLabel [
	| color angle delta |
	color := aRSLabel color.
	angle := self angleFor: aRSLabel.
	delta := angle isZero
		ifTrue: [ 100@0 ]
		ifFalse: [ -20@ -100 ].
	stream << '<a-entity position="'.
	self write3DPoint: aRSLabel position+delta .
	angle isZero ifFalse: [ 
		stream 
			<< '" rotation="0 0 ';
			<< angle asString
		 ].
	stream 
		<< '" text="width: 1.5';
		<< '; color: #';
		<< color asHexString;
		<< '; value: ';
		<< aRSLabel text;
		<< '" ></a-entity>'


]

{ #category : #visiting }
RSAFrameExporter >> visitLine: aRSLine [
	| color |
	color := aRSLine color asHexString.
	stream << '<a-entity line= "start: '.
	self write3DPoint: aRSLine startPoint.
	stream  << '; end: '.
	self write3DPoint: aRSLine endPoint.
	stream 
		<< '; color: #';
		<< color; 
		<< '"></a-entity>'.
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
  <script>
  AFRAME.registerComponent(''change-color-on-hover'', {
    schema: {
      color: {default: ''1F77B4''}
    },

    init: function () {
      var data = this.data;
      var el = this.el;  // <a-box>
      var defaultColor = el.getAttribute(''material'').color;
		var aTextPopUP = document.querySelector(''#idPopUP'');

      el.addEventListener(''mouseenter'', function () {
        el.setAttribute(''color'', data.color);
        var txtInfo = ''Height: ''+ el.getAttribute(''height'') + ''\n'' + ''Width: ''+ el.getAttribute(''width'') + ''\n'' + ''Depth: ''+ el.getAttribute(''depth'');
        document.getElementById(''idPopUP'').value = txtInfo;
        console.log(document.getElementById(''idPopUP'').value);
        aTextPopUP.setAttribute(''value'',txtInfo);
      });

      el.addEventListener(''mouseleave'', function () {
        el.setAttribute(''color'', defaultColor);
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
'.
]

{ #category : #writing }
RSAFrameExporter >> writeShapes [

	self write: '
<a-scene background="color: #fff" stats>
<a-assets>
<a-image id="floor" src="'.
	self write: self floorImgBase64.
	self write: '"></a-image>
</a-assets>'.

	shouldRenderFloor ifTrue: [ 
		self write:
			'<a-entity geometry="primitive: cylinder; height: .2; radius: 12;" material="color: #BABABA; src: #floor; metalness: .2; repeat: 50 20; roughness: .1" position="0 0 0"></a-entity>
' ].
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
