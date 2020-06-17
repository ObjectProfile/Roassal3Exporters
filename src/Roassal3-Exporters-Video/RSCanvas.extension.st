Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Exporters-Video' }
RSCanvas >> exportToVideo [
	^ self videoExporter export
]

{ #category : #'*Roassal3-Exporters-Video' }
RSCanvas >> videoExporter [
	^ RSVideoExporter new
		canvas: self;
		yourself
]
