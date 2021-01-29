Class {
	#name : #RSAFrameExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'aFrameExporter'
	],
	#category : #'Roassal3-Exporters-AFrame-Tests'
}

{ #category : #running }
RSAFrameExporterTest >> setUp [
	super setUp.
	aFrameExporter := RSAFrameExporter new.
	aFrameExporter stream: (WriteStream on: String new).
]

{ #category : #tests }
RSAFrameExporterTest >> testBorder [
	| result box |
	result := '<a-box position=''0.15 -0.15 0.0'' width='' 0.006 '' height='' 0.42426406871192857'' depth='' 0.003'' color= ''#404040'' rotation='' 0 0 -135.0'' roughness='' 1.0'' metalness='' 0.2'' ></a-box>', String crlf,'<a-box position=''-0.15 0.15 0.0'' width='' 0.006 '' height='' 0.42426406871192857'' depth='' 0.003'' color= ''#404040'' rotation='' 0 0 45.0'' roughness='' 1.0'' metalness='' 0.2'' ></a-box>', String crlf,'<a-box position=''0.15 -0.15 0.0'' width='' 0.006 '' height='' 0.42426406871192857'' depth='' 0.003'' color= ''#404040'' rotation='' 0 0 -135.0'' roughness='' 1.0'' metalness='' 0.2'' ></a-box>', String crlf,'<a-box position=''-0.15 0.15 0.0'' width='' 0.006 '' height='' 0.42426406871192857'' depth='' 0.003'' color= ''#404040'' rotation='' 0 0 45.0'' roughness='' 1.0'' metalness='' 0.2'' ></a-box>'.
	box := RSBox new.
	box width: 100.
	box height: 100.
	box printBorderOnAFrame: aFrameExporter.
	self assert: aFrameExporter stream contents equals: result.
]

{ #category : #tests }
RSAFrameExporterTest >> testBox [
	| result box |
	result := '<a-box position=''0.0 0.0 0.0'' width='' 0.03 '' height='' 0.03'' depth='' 0.003'' color= ''#9F9F9F'' change-color-on-hover=''color: #E9E9E9'' roughness='' 1.0'' metalness='' 0.2'' ></a-box>'.
	box := RSBox new.
	box printOnAFrame: aFrameExporter.
	self assert: aFrameExporter stream contents equals: result.
]

{ #category : #tests }
RSAFrameExporterTest >> testComposite [
	| result box composite |
	result := '<a-box position=''0.0 0.0 0.0'' width='' 0.06 '' height='' 0.06'' depth='' 0.003'' color= ''#0000FF'' change-color-on-hover=''color: #C4C4FF'' roughness='' 1.0'' metalness='' 0.2'' ></a-box>', String crlf,'<a-box position=''0.0 0.0 0.003'' width='' 0.06 '' height='' 0.06'' depth='' 0.003'' color= ''#9F9F9F'' change-color-on-hover=''color: #E9E9E9'' roughness='' 1.0'' metalness='' 0.2'' ></a-box>'.
	composite := RSComposite new.
	composite color: Color blue.
	box := RSBox new.
	box size: 10.
	composite children: { box }.
	self assert: composite extent equals: 10@10.
	composite accept: aFrameExporter.
	self assert: aFrameExporter stream contents equals: result.
]

{ #category : #tests }
RSAFrameExporterTest >> testElipse [
	| result elipse |
	result := '<a-entity geometry='' primitive: cylinder; height: 0.03; radius: 0.015  ''  position=''0.0 0.0 0.0'' rotation='' 90 0 0''  material= ''color: #9F9F9F; blending: multiply; transparent: true'' change-color-on-hover=''color: #E9E9E9'' roughness='' 1.0'' metalness='' 0.2'' ></a-entity>'.
	elipse := RSEllipse new.
	elipse printOnAFrame: aFrameExporter.
	self assert: aFrameExporter stream contents equals: result.
]

{ #category : #tests }
RSAFrameExporterTest >> testImage [
	| stream imgFloor |
	imgFloor 	:= 'https://i.imgur.com/dckg70j.jpg'.
	stream := RSAFrameExporter new.
	self assert: stream floorImg  equals: imgFloor.
]

{ #category : #tests }
RSAFrameExporterTest >> testLabel [
	| result label |
	result := '<a-entity position=''0.0 0.0 0.0'' text='' width: 1.6341; color: #808080; value:hello world; align: center'' ></a-entity>'.
	label := RSLabel new.
	label text: 'hello world'.
	label printOnAFrame: aFrameExporter.
	self assert: aFrameExporter stream contents equals: result.
]

{ #category : #tests }
RSAFrameExporterTest >> testLine [
	| result line |
	result := '<a-entity geometry=''primitive: cylinder; radius: 0.003; height:0.8485281374238571'' position='' 0.3 -0.3 0.0'' rotation='' 0 0 -135.0'' material='' color:#404040''></a-entity>'.
	line := RSLine new.
	line printOnAFrame: aFrameExporter.
	self assert: aFrameExporter stream contents equals: result.
]
