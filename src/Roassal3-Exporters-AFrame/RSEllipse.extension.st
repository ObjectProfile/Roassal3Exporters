Extension { #name : #RSEllipse }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSEllipse >> printOnAFrame: aRSAFrameExporter [ 
	| stream extent color scale radius |
	scale := 0.006.
	scale := scale @ scale negated.
	stream := aRSAFrameExporter stream.
	extent := self extent * scale abs.
	color := self color.
	color ifNil: [ ^self ].
	radius := extent / 2.0.
	stream << '<a-sphere '.
	self model ifNotNil: [ stream <<'model="'; << self model asString; <<'" ' ].
	stream
		<< 'radius="';
		<< radius x asString; space;
		<< radius y asString; space;
		<< (radius x min: radius y) asString;
		<< '" position="'.
	aRSAFrameExporter write3DPoint: self position.
	stream 
		<< '" color= "#';
		<< color asHexString;
		<< '" change-color-on-hover="color: #';
		<< color muchLighter asHexString;
		<< '" roughness=" 1.0" metalness=" 0.2" ></a-sphere>'.
]
