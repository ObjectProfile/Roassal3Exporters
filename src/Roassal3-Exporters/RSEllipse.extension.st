Extension { #name : #RSEllipse }

{ #category : #'*Roassal3-Exporters' }
RSEllipse >> writeSVG2On: aRSSVG2Exporter [ 
	| rect pos ext s |
	rect := self baseRectangle.
	pos := rect floatCenter.
	ext := rect extent/2.
	s := aRSSVG2Exporter stream.
	s
		<< '<ellipse ';
		<< 'cx="0" cy="0" rx="';
		<< ext x asSVGString;
		<< '" ry="';
		<< ext y asSVGString;
		<< '" '.
	aRSSVG2Exporter writeSVGStyleFor: self.
	aRSSVG2Exporter writeMatrix: aRSSVG2Exporter pathTransform.
	s << '/>'; crlf.
]
