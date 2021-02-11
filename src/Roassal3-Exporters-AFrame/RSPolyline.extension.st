Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSPolyline >> printOnAFrame: aRSAFrameExporter [
	| points prevPoint |
	points := self controlPoints.
	points ifEmpty: [ ^self ].
	prevPoint := points first.
	points allButFirst do: [ :curPoint | 
		curPoint = prevPoint ifFalse: [ 
			aRSAFrameExporter writeLine: prevPoint endPoint: curPoint border: self border.
			aRSAFrameExporter stream	crlf ].
		
		prevPoint := curPoint.
		].
	
]
