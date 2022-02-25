"
This new exporter, is similar to RTSVGExporter from roassal2 a pure smalltalk object that allow to the user to convert the roassal3 shapes into an svg shape
"
Class {
	#name : #RSSVGExporter,
	#superclass : #RSRoassalExporter,
	#instVars : [
		'stream',
		'pathTransform',
		'maxSize',
		'convertions',
		'shouldUsePathLabel',
		'shouldHaveFontDefs',
		'exporterFontStrategy'
	],
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSSVGExporter >> disableFontDefs [
	shouldHaveFontDefs := false
]

{ #category : #public }
RSSVGExporter >> doNotUsePathLabel [
	shouldUsePathLabel := false
]

{ #category : #public }
RSSVGExporter >> enableFontDefs [
	shouldHaveFontDefs := true
]

{ #category : #public }
RSSVGExporter >> exportToFile: file [
	file writeStreamDo: [ :aStream | self exportToStream: aStream ].
	
]

{ #category : #public }
RSSVGExporter >> exportToStream: aStream [
	| morph |
	morph := self morph.
	self cameraSetter set: [ 
			canvas := morph roassalCanvas.
			morph drawShapes.
			stream := aStream.
			canvas accept: self.
		].
	
]

{ #category : #accessing }
RSSVGExporter >> exporterFontStrategy: strategy [
	self assert: strategy class superclass = RSExporterFontStrategy.
	exporterFontStrategy := strategy 
]

{ #category : #accessing }
RSSVGExporter >> extension [
	^ 'svg'
]

{ #category : #initialization }
RSSVGExporter >> initialize [

	super initialize.
	self
		initializeSpecialCharacters;
		maxSize: 500;
		doNotUsePathLabel;
		enableFontDefs";
		fontURLServer: 'https://fonts.googleapis.com/css2?family='"
]

{ #category : #initialization }
RSSVGExporter >> initializeSpecialCharacters [
	convertions := Dictionary new
		at: $™ put: '&#8482;';
		at: $\ put: '&#92;';
		at: $€ put: '&euro;';
		at: $  put: '&#160;';
		at: $" put: '&quot;';
		at: $& put: '&amp;';
		at: $< put: '&lt;';
		at: $> put: '&gt;';
		at: $¡ put: '&iexcl;';
		at: $¢ put: '&cent;';
		at: $£ put: '&pound;';
		at: $¤ put: '&curren;';
		at: $¥ put: '&yen;';
		at: $¦ put: '&brvbar;';
		at: $§ put: '&sect;';
		at: $¨ put: '&uml;';
		at: $© put: '&copy;';
		at: $ª put: '&ordf;';
		at: $¬ put: '&not;';
		at: $® put: '&reg;';
		at: $¯ put: '&macr;';
		at: $° put: '&deg;';
		at: $± put: '&plusmn;';
		at: $² put: '&sup2;';
		at: $³ put: '&sup3;';
		at: $´ put: '&acute;';
		at: $µ put: '&micro;';
		at: $¶ put: '&para;';
		at: $· put: '&middot;';
		at: $¸ put: '&cedil;';
		at: $¹ put: '&sup1;';
		at: $º put: '&ordm;';
		at: $» put: '&raquo;';
		at: $¼ put: '&frac14;';
		at: $½ put: '&frac12;';
		at: $¾ put: '&frac34;';
		at: $¿ put: '&iquest;';
		at: $À put: '&Agrave;';
		at: $Á put: '&Aacute;';
		at: $Â put: '&Acirc;';
		at: $Ã put: '&Atilde;';
		at: $Ä put: '&#196;';
		at: $Å put: '&Aring;';
		at: $Æ put: '&AElig;';
		at: $Ç put: '&Ccedil;';
		at: $È put: '&Egrave;';
		at: $É put: '&Eacute;';
		at: $Ê put: '&Ecirc;';
		at: $Ë put: '&Euml;';
		at: $Ì put: '&Igrave;';
		at: $Í put: '&Iacute;';
		at: $Î put: '&Icirc;';
		at: $Ï put: '&Iuml;';
		at: $Ð put: '&ETH;';
		at: $Ñ put: '&Ntilde;';
		at: $Ò put: '&Ograve;';
		at: $Ó put: '&Oacute;';
		at: $Ô put: '&Ocirc;';
		at: $Õ put: '&Otilde;';
		at: $Ö put: '&Ouml;';
		at: $× put: '&times;';
		at: $Ø put: '&Oslash;';
		at: $Ù put: '&Ugrave;';
		at: $Ú put: '&Uacute;';
		at: $Û put: '&Ucirc;';
		at: $Ü put: '&Uuml;';
		at: $Ý put: '&Yacute;';
		at: $Þ put: '&THORN;';
		at: $ß put: '&szlig;';
		at: $à put: '&agrave;';
		at: $á put: '&aacute;';
		at: $â put: '&acirc;';
		at: $ã put: '&atilde;';
		at: $ä put: '&#228;';
		at: $å put: '&aring;';
		at: $æ put: '&aelig;';
		at: $ç put: '&ccedil;';
		at: $è put: '&egrave;';
		at: $é put: '&eacute;';
		at: $ê put: '&ecirc;';
		at: $ë put: '&euml;';
		at: $ì put: '&igrave;';
		at: $í put: '&iacute;';
		at: $î put: '&icirc;';
		at: $ï put: '&iuml;';
		at: $ð put: '&eth;';
		at: $ñ put: '&ntilde;';
		at: $ò put: '&ograve;';
		at: $ó put: '&oacute;';
		at: $ô put: '&ocirc;';
		at: $õ put: '&otilde;';
		at: $ö put: '&ouml;';
		at: $÷ put: '&divide;';
		at: $ø put: '&oslash;';
		at: $ù put: '&ugrave;';
		at: $ú put: '&uacute;';
		at: $û put: '&ucirc;';
		at: $ü put: '&uuml;';
		at: $ý put: '&yacute;';
		at: $þ put: '&thorn;';
		at: $⁰ put: '&#8304;';
		at: $¹ put: '&#185;';
		at: $² put: '&#178;';
		at: $³ put: '&#179;';
		at: $⁴ put: '&#8308;';
		at: $⁵ put: '&#8309;';
		at: $⁶ put: '&#8310;';
		at: $⁷ put: '&#8311;';
		at: $⁸ put: '&#8312;';
		at: $⁹ put: '&#8313;';
		at: Character cr put: '';
		yourself
]

{ #category : #accessing }
RSSVGExporter >> maxSize [
	^ maxSize
]

{ #category : #accessing }
RSSVGExporter >> maxSize: aNumber [
	maxSize := aNumber 
]

{ #category : #'accessing - matrices' }
RSSVGExporter >> pathTransform [
	^ pathTransform
]

{ #category : #public }
RSSVGExporter >> scaledSVGNumber: aNumber [
	| pt p1 p2 |
	pt := self pathTransform.
	p1 := pt transform: 0@0.
	p2 := pt transform: aNumber @ 0.
	^ (p1 distanceTo: p2) asSVGString
]

{ #category : #testing }
RSSVGExporter >> shouldUsePathLabel [
	^ shouldUsePathLabel
]

{ #category : #accessing }
RSSVGExporter >> stream [
	^ stream
]

{ #category : #public }
RSSVGExporter >> usePathLabel [
	shouldUsePathLabel := true
]

{ #category : #visiting }
RSSVGExporter >> visitBoundingShape: aShape [
	self pathTransform restoreAfter: [ 
		self pathTransform
			multiplyBy: aShape matrix asFloatTransform.
		aShape writeSVG2On: self.
		self visitChildrenIfNecessary: aShape.
	].
	
]

{ #category : #visiting }
RSSVGExporter >> visitCanvas: aRSCanvas [ 
	| extent |
	pathTransform := AthensAffineTransform new.
	extent := aRSCanvas extent.
	pathTransform
		translateBy: (extent / 2) asFloatPoint;
		scaleBy: aRSCanvas camera scale asFloat;
		translateBy: aRSCanvas camera position negated asFloatPoint.
	self 
		write: '<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="'.
	self stream
		<< extent x asSVGString;
		<< 'pt" height="';
		<< extent y asSVGString;
		<< 'pt" viewBox="0 0 ';
		<< extent x asSVGString;
		<< ' ';
		<< extent y asSVGString;
		<< '" style="background-color:#';
		<< canvas color asHexString.
	self write: '" version="1.1">
'.
	self writeLabelDefinitionsIfNecessary: aRSCanvas.
	aRSCanvas shapes do: [ :shape | shape accept: self ].
	self write: '</svg>'.
]

{ #category : #'visiting - helpers' }
RSSVGExporter >> visitChildrenIfNecessary: shape [
	shape hasChildren ifFalse: [ ^ self ].
	shape children do: [ :child | child accept: self ].
	
	
]

{ #category : #visiting }
RSSVGExporter >> visitLabel: label [
	label hasText ifFalse: [ ^ self ].
	self pathTransform restoreAfter: [ 
		self pathTransform
			multiplyBy: label matrix asFloatTransform;
			translateBy: label textExtents translationPoint.
		self shouldUsePathLabel
			ifTrue: [ self writePathLabel: label ]
			ifFalse: [ self writeSimpleLabel: label ].
	].
	
]

{ #category : #visiting }
RSSVGExporter >> visitLine: line [
	line writeSVG2On: self.
	line markerShapesInPositionDo: [ :shape | shape accept: self ]
]

{ #category : #'visiting - helpers' }
RSSVGExporter >> write: aString [
	stream nextPutAll: (aString copyReplaceAll: String cr with: String crlf)
]

{ #category : #'visiting - helpers' }
RSSVGExporter >> writeFont: label [

	| font s metricProvider extents |
	font := label font.
	s := self stream.
	metricProvider := RSCairoFitMetricsProvider new.
	extents := metricProvider extentsOf: label.
	s << ' style="font-family: '''.
	exporterFontStrategy 
		ifNil: [ s << font familyName ] 
		ifNotNil: [ s << (exporterFontStrategy fontName: font familyName) ].
	s
		<< '''; font-size: ';
		<< font pixelSize asFloat asString;
		"<< (extents height asString);""<< (label textExtents y_bearing abs asString);""<< (self scaledSVGNumber: font pointSize*0.83);"
		<< 'px;'.

	"s << ' font-weight: '; << font weightValue asSVGString; << ';'.
	s << ' font-stretch: '; << font stretchValue asSVGString; << '%;'."
	label isBold ifTrue: [ s << ' font-weight: bold;' ].
	label isItalic ifTrue: [ s << ' font-style: italic;' ].
	label isStruckOut ifTrue: [ s << ' text-decoration: line-through;' ].
	label isUnderlined ifTrue: [ s << ' text-decoration: underline;' ].
	s
		<< '" textLength="';
		"<< label textWidth asSVGString;""<< (extents x_advance asString);"
		<< extents x_advance asString;
		<< '" lengthAdjust="spacingAndGlyphs" ' "width asFloat"

	"<< '"" '."
]

{ #category : #'visiting - helpers' }
RSSVGExporter >> writeLabelDefinitionsIfNecessary: aRSCanvas [

	| allLabels fonts |
	shouldHaveFontDefs ifFalse: [ ^ self ].
	shouldUsePathLabel ifTrue: [ ^ self ].
	allLabels := aRSCanvas allChildren select: [ :shape | shape isLabel ].
	allLabels ifEmpty: [ ^ self ].
	fonts := allLabels
		         collect: [ :label | label font familyName ]
		         as: Set.
	fonts := fonts asSortedCollection.

	self write: '<defs>
<style>'.
	exporterFontStrategy ifNil: [ exporterFontStrategy := RSExporterUsingURL new ].
	exporterFontStrategy export: fonts on: self stream.
	self write: '
</style>
</defs>
'
]

{ #category : #'visiting - helpers' }
RSSVGExporter >> writeMatrix: matrix [
	self stream
		<< 'transform="matrix(';
		<< matrix sx asSVGString;
		<< ',';
		<< matrix shy asSVGString;
		<< ',';
		<< matrix shx asSVGString;
		<< ',';
		<< matrix sy asSVGString;
		<< ',';
		<< matrix x asSVGString;
		<< ',';
		<< matrix y asSVGString;
		<< ')" '
]

{ #category : #'visiting - helpers' }
RSSVGExporter >> writePathLabel: label [
	| copy newCanvas file i1 i2 path contents s |
	copy := label copy.
	copy announcer: nil.
	copy withBorder.
	newCanvas := RSCanvas new.
	newCanvas add: copy.
	file := newCanvas svgCairoExporter export asFileReference.
	contents := file contents.
	i1 := (contents indexOfSubCollection: 'd="M')+3.
	i2 := (contents indexOf: $" startingAt: i1)-1.
	path := contents copyFrom: i1 to: i2.
	file delete.
	s := self stream.
	s 
		<< '<path d="';
		<< path;
		<< '" '.
	self writeMatrix: self pathTransform.
	self writeSVGStyleFor: label.
	s
		<< '/>';
		crlf
		
	
	
]

{ #category : #'visiting - helpers' }
RSSVGExporter >> writePoint: aPoint sep: aString [
	self stream
		<< aPoint x asSVGString;
		<< aString;
		<< aPoint y asSVGString;
		space.
]

{ #category : #public }
RSSVGExporter >> writeSVGStyleFor: aShape [
	| fill fillOpacity aBorder s style |
	s := self stream.
	aShape paint ifNil: [ 
		fill := 'none'.
		fillOpacity := 1 ]
	ifNotNil: [:p | 
		fill := '#',p asHexString.
		fillOpacity := p alpha ].
	s
		<< 'fill="';
		<< fill;
		<< '" '.
	(fillOpacity asFloat closeTo: 1) ifFalse: [ 
		s
			<< 'fill-opacity="';
			<< fillOpacity asSVGString;
			<< '" ' ]. 
	aBorder := aShape border.
	aBorder ifNil: [ ^ self ].
	s
		<< 'stroke="#';
		<< aBorder paint asHexString;
		<< '" stroke-width="';
		<< (self scaledSVGNumber: aBorder width);
		<< '" '.
	style := aBorder style.
	style ifNil: [ ^ self ].
	style dashArray ifNotNil: [ :array | 
		s << 'stroke-dasharray="'.
		array do: [ :n | s << (self scaledSVGNumber: n) ] separatedBy: [ s space ].
		s
			<< '" stroke-dashoffset="';
			<< (self scaledSVGNumber: aBorder style dashOffset);
			<< '" '
	].
	
	style capStyle ifNotNil: [ :cap |
		s
			<< 'stroke-linecap="';
			<< (cap copyFrom: 4 to: cap size);
			<< '" '.
		 ].
	style joinStyle ifNotNil: [ :join |
		s
			<< 'stroke-linejoin="';
			<< (join copyFrom: 5 to: join size);
			<< '" '.
		 ].
	


]

{ #category : #'visiting - helpers' }
RSSVGExporter >> writeSimpleLabel: label [
	self stream
		<< '<text'.
	self writeFont: label.
	self writeMatrix: self pathTransform.
	self writeSVGStyleFor: label.
	self stream
		<< '>'
		<< (label text truncateTo: maxSize) asHTMLString;
		<< '</text>';
		crlf.
	
	
]
