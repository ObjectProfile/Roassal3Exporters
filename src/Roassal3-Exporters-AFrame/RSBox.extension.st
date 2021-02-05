Extension { #name : #RSBox }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSBox >> printBorderOnAFrame: aRSAFrameExporter [
	aRSAFrameExporter writeBorder: matrix translation  endPoint: self baseRectangle corner.
	aRSAFrameExporter stream crlf.
	aRSAFrameExporter writeBorder: matrix translation endPoint: self baseRectangle origin.
	aRSAFrameExporter stream crlf.
	aRSAFrameExporter writeBorder: matrix translation negated endPoint: self baseRectangle corner.
	aRSAFrameExporter stream crlf.
	aRSAFrameExporter writeBorder: matrix translation negated endPoint: self baseRectangle origin.

]

{ #category : #'*Roassal3-Exporters-AFrame' }
RSBox >> printOnAFrame: aRSAFrameExporter [ 
	aRSAFrameExporter writeSolidBox: self.
]
