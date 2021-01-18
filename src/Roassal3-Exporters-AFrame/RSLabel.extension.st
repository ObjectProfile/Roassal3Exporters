Extension { #name : #RSLabel }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSLabel >> printOnAFrame: aRSAFrameExporter [ 
	| stream color angle |
	stream := aRSAFrameExporter stream.
	color := self color.
	color ifNil: [ ^self ].
	angle := aRSAFrameExporter angleFor: self.
	stream << '<a-entity position="'.
	aRSAFrameExporter write3DPoint: self position .
	angle isZero ifFalse: [ 
	stream  
		<< '" rotation="0 0 ';
		<< angle asString
		 ].
	stream 
		<< '" text="width: ';
		<< (self baseRectangle corner y * 0.2) asString;
		<< '; color: #';
		<< color asHexString;
		<< '; value:';
		<< self text;
		<< '; align: center" ></a-entity>'
]
