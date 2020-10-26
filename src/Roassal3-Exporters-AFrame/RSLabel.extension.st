Extension { #name : #RSLabel }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSLabel >> printOnAFrame: aRSAFrameExporter [ 
	| stream color angle delta |
	stream := aRSAFrameExporter stream.
	color := self color.
	color ifNil: [ ^self ].
	angle := aRSAFrameExporter angleFor: self.
	delta := angle isZero
		ifTrue: [ 100@0 ]
		ifFalse: [ -20@ -100 ].
	stream << '<a-entity position="'.
	aRSAFrameExporter write3DPoint: self position+delta .
	angle isZero ifFalse: [ 
	stream 
		<< '" rotation="0 0 ';
		<< angle asString
		 ].
	stream 
		<< '" text="width: 1.5';
		<< '; color: #';
		<< color asHexString;
		<< '; value:';
		<< self text;
		<< '" ></a-entity>'
]
