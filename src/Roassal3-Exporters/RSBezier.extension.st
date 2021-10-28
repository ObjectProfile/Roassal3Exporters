Extension { #name : #RSBezier }

{ #category : #'*Roassal3-Exporters' }
RSBezier >> writeSVG2On: aRSSVG2Exporter [ 
	| pt s points |
	pt := aRSSVG2Exporter pathTransform.
	s := aRSSVG2Exporter stream.
	points := self controlPoints collect: [:p | pt transform: p ].
	s << '<path d="M '.
	aRSSVG2Exporter writePoint: points first sep: ' '.
	points size == 2 ifTrue: [ 
		s<< 'L '.
		aRSSVG2Exporter writePoint: points last sep: ' '.
	] ifFalse: [ points size == 3 ifTrue: [ 
		s << 'Q '.
		aRSSVG2Exporter 
			writePoint: points second sep: ' ';
			writePoint: points third sep: ' '.
	] ifFalse: [
		s << 'C '.
		aRSSVG2Exporter 
			writePoint: points second sep: ' ';
			writePoint: points third sep: ' ';
			writePoint: points fourth sep: ' '.
	] ].
	s << '" '.
	aRSSVG2Exporter writeSVGStyleFor: self.
	s << '/>'; crlf.
]
