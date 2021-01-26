Extension { #name : #RSLine }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSLine >> printOnAFrame: aRSAFrameExporter [ 
	| stream color angle height scale |
	stream := aRSAFrameExporter stream.
	scale := 0.006.
	color := self color muchDarker asHexString.
	angle := ((self endPoint - self startPoint ) angle + Float halfPi ) negated radiansToDegrees.
	height := (self startPoint distanceTo: self endPoint ) * scale abs.
	stream 
		<< '<a-entity geometry="primitive: cylinder; radius: ';
		<< (aRSAFrameExporter depthSize * scale ) asString;
		<< '; height:';
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
