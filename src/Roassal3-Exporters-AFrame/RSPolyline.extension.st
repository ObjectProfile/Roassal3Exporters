Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSPolyline >> printOnAFrame: aRSAFrameExporter [
	| points prevPoint |
	points := self controlPoints.
	points ifEmpty: [ ^self ].
	prevPoint := points first.
	points allButFirst do: [ :curPoint | 
		aRSAFrameExporter writeLine: prevPoint endPoint: curPoint color: self color.
		prevPoint := curPoint.
		].
	
]
