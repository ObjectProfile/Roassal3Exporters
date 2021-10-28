Extension { #name : #RSLine }

{ #category : #'*Roassal3-Exporters' }
RSLine >> writeSVG2On: aRSSVG2Exporter [ 
	| p1 p2 s pt |
	pt := aRSSVG2Exporter pathTransform.
	p1 := pt transform: self startPoint.
	p2 := pt transform: self endPoint.
	s := aRSSVG2Exporter stream.
	s
		<< '<line ';
		<< 'x1="';
		<< p1 x asSVGString;
		<< '" y1="';
		<< p1 y asSVGString;
		<< '" x2="';
		<< p2 x asSVGString;
		<< '" y2="';
		<< p2 y asSVGString;
		<< '" '.
	aRSSVG2Exporter writeSVGStyleFor: self.
	s << '/>'; crlf.
]
