Extension { #name : #RSEllipse }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSEllipse >> printOnAFrame: aRSAFrameExporter [ 
	aRSAFrameExporter writeSolidEllipse: self.
]
