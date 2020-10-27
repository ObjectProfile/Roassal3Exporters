Extension { #name : #RSBox }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSBox >> printOnAFrame: aRSAFrameExporter [ 
	| stream extent color scale |
	scale := 0.006.
	scale := scale @ scale negated.
	stream := aRSAFrameExporter stream.
	extent := self extent * scale abs.
	color := self color.
	color ifNil: [ ^ self ].
	stream << '<a-box '. 
	self model ifNotNil: [ stream <<'model="'; << self model asString; <<'" ' ].
	stream <<'position="'.
	aRSAFrameExporter write3DPoint: self position.
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
		<< '" roughness=" 1.0" metalness=" 0.2" ></a-box>'.
]
