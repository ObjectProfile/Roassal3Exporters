Extension { #name : #RSBoundingShape }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSBoundingShape >> printBorderOnAFrame: aRSAFrameExporter [
	aRSAFrameExporter writeSolidBorder: self

]

{ #category : #'*Roassal3-Exporters-AFrame' }
RSBoundingShape >> printOnAFrame: aRSAFrameExporter [ 
	aRSAFrameExporter writeSolidBox: self.
]
