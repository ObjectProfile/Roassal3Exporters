Extension { #name : #RSBoundingShape }

{ #category : #'*Roassal3-Exporters' }
RSBoundingShape >> writeSVG2On: aRSSVG2Exporter [
	| rect pos ext s |
	rect := self baseRectangle.
	pos := rect topLeft.
	ext := rect extent.
	s := aRSSVG2Exporter stream.
	s
		<< '<rect ';
		<< 'x="';
		<< pos x asSVGString;
		<< '" y="';
		<< pos y asSVGString;
		<< '" width="';
		<< ext x asSVGString;
		<< '" height="';
		<< ext y asSVGString;
		<< '" '.
	aRSSVG2Exporter writeSVGStyleFor: self.
	aRSSVG2Exporter writeMatrix: aRSSVG2Exporter pathTransform.
	s << '/>'; crlf.
]
