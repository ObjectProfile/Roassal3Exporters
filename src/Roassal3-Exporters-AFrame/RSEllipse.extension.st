Extension { #name : #RSEllipse }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSEllipse >> printBorderOnAFrame: aRSAFrameExporter [ 

]

{ #category : #'*Roassal3-Exporters-AFrame' }
RSEllipse >> printOnAFrame: aRSAFrameExporter [ 
	aRSAFrameExporter writeEllipse: self.
]
