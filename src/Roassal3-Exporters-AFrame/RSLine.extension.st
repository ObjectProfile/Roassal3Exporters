Extension { #name : #RSLine }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSLine >> printOnAFrame: aRSAFrameExporter [ 
	| stream color extent angle height scale delta |
	stream := aRSAFrameExporter stream.
	scale := 0.006.
	"scale := scale @ scale negated."
	color := self color muchDarker asHexString.
	extent := self extent * scale abs.
	angle := ((self endPoint - self startPoint ) angle + Float halfPi ) negated radiansToDegrees.
	height := (self startPoint distanceTo: self endPoint ) * scale abs.
		delta := angle isZero
		ifTrue: [ 100@0 ]
		ifFalse: [ -20@ -100 ].
	stream << '<a-entity geometry="primitive: cylinder; radius: 0.003; '
		<< 'height:';
		<< height asString ;
		<<'" position=" '.
	aRSAFrameExporter write3DPoint: self position.
	angle isZero ifFalse: [ 
	stream 
		<< '" rotation=" 0 0 ';
		<< angle asString
		].
	stream  
		<< '" material=" color:#';
		<< color; 
		<< '"></a-entity>'.



]
