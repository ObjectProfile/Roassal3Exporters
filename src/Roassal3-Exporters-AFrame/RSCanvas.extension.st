Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSCanvas >> aFrameExporter [
	^ RSAFrameExporter new
		canvas: self;
		yourself
]

{ #category : #'*Roassal3-Exporters-AFrame' }
RSCanvas >> exportToAFrame [
	^ self aFrameExporter export
]
