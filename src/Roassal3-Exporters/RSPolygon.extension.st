Extension { #name : #RSPolygon }

{ #category : #'*Roassal3-Exporters' }
RSPolygon >> writeSVG2On: aRSSVG2Exporter [
| s pt |
	s := aRSSVG2Exporter stream.
 	pt := aRSSVG2Exporter pathTransform.
	s << '<polyline points="'.
	self points do: [ :p | | np |
		np := pt transform: p.
		s 
			<< np x asSVGString;
			<< ',';
			<< np y asSVGString;
			<< ' ' ].
	s << '" '.
	aRSSVG2Exporter writeSVGStyleFor: self.
	s << '/>'; crlf
		
]
