Extension { #name : #RSLine }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSLine >> printOnAFrame: aRSAFrameExporter [ 
	aRSAFrameExporter writeLine: self startPoint endPoint: self endPoint border: self border.



]
