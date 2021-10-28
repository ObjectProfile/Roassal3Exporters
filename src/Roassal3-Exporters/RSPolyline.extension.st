Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Exporters' }
RSPolyline >> writeSVG2On: aRSSVG2Exporter [
	| s pt |
	s := aRSSVG2Exporter stream.
 	pt := aRSSVG2Exporter pathTransform.
	s << '<polyline points="'.
	self controlPoints do: [ :p | | np |
		np := pt transform: p.
		aRSSVG2Exporter writePoint: np sep: ','.
		s space ].
	s << '" '.
	aRSSVG2Exporter writeSVGStyleFor: self.
	s << '/>'; crlf
		
]
