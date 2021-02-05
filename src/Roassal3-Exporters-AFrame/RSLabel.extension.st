Extension { #name : #RSLabel }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSLabel >> printOnAFrame: aRSAFrameExporter [ 
	aRSAFrameExporter writeLabel: self.
]
