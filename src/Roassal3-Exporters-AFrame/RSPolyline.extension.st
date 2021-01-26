Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSPolyline >> printOnAFrame: aRSAFrameExporter [ 
	aRSAFrameExporter writeSolidPolyline: self.
]
