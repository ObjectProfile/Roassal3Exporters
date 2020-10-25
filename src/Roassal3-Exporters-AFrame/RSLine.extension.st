Extension { #name : #RSLine }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSLine >> printOnAFrame: aRSAFrameExporter [ 
	| stream color |
	stream := aRSAFrameExporter stream.
	color := self color muchDarker asHexString.
	stream << '<a-entity line= "start: '.
	aRSAFrameExporter write3DPoint: self startPoint.
	stream  << '; end: '.
	aRSAFrameExporter write3DPoint: self endPoint.
	stream 
		<< '; color: #';
		<< color ; 
		<< '"></a-entity>'.
]
