"
A RSSVG2ExporterTest is a test class for testing the behavior of RSSVG2Exporter
"
Class {
	#name : #RSSVG2ExporterTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Exporters-Tests-Core'
}

{ #category : #running }
RSSVG2ExporterTest >> tearDown [
	"'./test2.svg' asFileReference delete"
]

{ #category : #tests }
RSSVG2ExporterTest >> testBezier [
	| canvas box1 box2 line file |
	canvas := RSCanvas new.
	canvas addShape: (RSBezier new
		color: Color red;
		controlPoints:
			{(0 @ 0).
			(100 @ 100).
			(200 @ 0).
			(300 @ 100)};
		yourself).
	box1 := RSBox new 
		draggable; 
		size: 100; 
		color: Color blue;
		translateTo: 100@ -200; 
		yourself.
	box2 := RSBox new
		draggable;
		size: 100;
		yourself.
	canvas
		add: box1;
		add: box2.
		
	line := RSBezier new
		withVerticalAttachPoint;
		from: box1;
		controlPointsController: RSVerticalCPAPController new;
		to: box2;
		yourself.
	canvas add: line.
	file := './test2.svg'.
	canvas svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<path d="M 250 250 C 350 350 450 250 550 350 " fill="none" stroke="#FF0000" stroke-width="1" />
<rect x="-50" y="-50" width="100" height="100" fill="#0000FF" transform="matrix(1,0,0,1,350,50)" />
<rect x="-50" y="-50" width="100" height="100" fill="#9F9F9F" transform="matrix(1,0,0,1,250,250)" />
<path d="M 350 100 C 350 150 250 150 250 200 " fill="none" stroke="#808080" stroke-width="1" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testBitmap [
	| c file |
	c := RSCanvas new.
	c addShape: (RSBitmap new
		form: (self iconNamed: #eyedropper);
		extent: 200@350).
	file := './test2.svg'.
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<image href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACYAAAAkCAMAAADSK7iXAAADAFBMVEX///8AAAD///99fX3/AAAA/wAAAP8A/////wAAAAAdHR0+Pj5dXV2dnZ28vLzd3d0FBQUNDQ0VFRUlJSUuLi42NjZGRkZOTk5VVVVlZWVtbW11dXWFhYWNjY2VlZWlpaWsrKy0tLTExMTMzMzV1dXl5eXt7e319fUAAAAAMQAAYwAAlwAAyQAA/wAAADEAMTEAYzEAlzEAyTEA/zEAAGMAMWMAY2MAl2MAyWMA/2MAAJcAMZcAY5cAl5cAyZcA/5cAAMkAMckAY8kAl8kAyckA/8kAAP8AMf8AY/8Al/8Ayf8A//8xAAAxMQAxYwAxlwAxyQAx/wAxADExMTExYzExlzExyTEx/zExAGMxMWMxY2Mxl2MxyWMx/2MxAJcxMZcxY5cxl5cxyZcx/5cxAMkxMckxY8kxl8kxyckx/8kxAP8xMf8xY/8xl/8xyf8x//9jAABjMQBjYwBjlwBjyQBj/wBjADFjMTFjYzFjlzFjyTFj/zFjAGNjMWNjY2Njl2NjyWNj/2NjAJdjMZdjY5djl5djyZdj/5djAMljMcljY8ljl8ljyclj/8ljAP9jMf9jY/9jl/9jyf9j//+XAACXMQCXYwCXlwCXyQCX/wCXADGXMTGXYzGXlzGXyTGX/zGXAGOXMWOXY2OXl2OXyWOX/2OXAJeXMZeXY5eXl5eXyZeX/5eXAMmXMcmXY8mXl8mXycmX/8mXAP+XMf+XY/+Xl/+Xyf+X///JAADJMQDJYwDJlwDJyQDJ/wDJADHJMTHJYzHJlzHJyTHJ/zHJAGPJMWPJY2PJl2PJyWPJ/2PJAJfJMZfJY5fJl5fJyZfJ/5fJAMnJMcnJY8nJl8nJycnJ/8nJAP/JMf/JY//Jl//Jyf/J////AAD/MQD/YwD/lwD/yQD//wD/ADH/MTH/YzH/lzH/yTH//zH/AGP/MWP/Y2P/l2P/yWP//2P/AJf/MZf/Y5f/l5f/yZf//5f/AMn/Mcn/Y8n/l8n/ycn//8kAAAD/Mf//Y///l///yf/////5sR1SAAABAHRSTlP///////////8A////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////AP//////OE00OwAAAR5JREFUeF6t1DGygjAQBmCHVkYroplhFBjzwmHouAidF8ALZOzSeYF4g1Smeu8CtlRJR5vqJejTV0CWwq2/2QnL/ruwdk4t7CfYj5IXmKnOaMkhdjO+5DHMlDF93xvZ4BD71oNyrAmx7ql4VQbYSzXlFFNK6f9qgslOaq/0U02wi2tjetPJYzWoqbdxZaQcWpWBn7Vfcfeqtxpn2ToquB/Enxpl2VdED7g5Vy81xpwi91Od1m81wnLqVJtYe64DLKeUXFsErKXvdcU1sL2riBKxXQJLnrtPFNsYyELhFUJAZJy6CxQDySr8uBAGAph7lcRATjM/riQF4rxfExEvUyD1rCACbcDjwA4t2sE3hKUYPDXsUTMuEpt3uD7LoPoFh1uzvVTXHQoAAAAASUVORK5CYII=" x="-19" y="-18" width="38" height="36" transform="matrix(5.2631578947368425,0,0,9.722222222222221,250,250)" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testBorderStylesCap [
	| c file |
	c := RSCanvas new.
	c addShape: (RSLine new
		startPoint: -100@ -100;
		endPoint: 100@ -100;
		width: 50;
		capRound;
		yourself).
	c addShape: (RSLine new
		startPoint: -100@ 0;
		endPoint: 100@ 0;
		width: 50;
		capButt;
		yourself).
	c addShape: (RSLine new
		startPoint: -100@ 100;
		endPoint: 100@ 100;
		width: 50;
		capSquare;
		yourself).
	file := './test2.svg'.
	
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<line x1="150" y1="150" x2="350" y2="150" fill="none" stroke="#808080" stroke-width="50" stroke-linecap="Round" />
<line x1="150" y1="250" x2="350" y2="250" fill="none" stroke="#808080" stroke-width="50" stroke-linecap="Butt" />
<line x1="150" y1="350" x2="350" y2="350" fill="none" stroke="#808080" stroke-width="50" stroke-linecap="Square" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testBoxes [
	| c file |
	c := RSCanvas new.
	c addShape: (RSBox new
		extent: 100@100;
		yourself).
	c addShape: (RSBox new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	file := './test2.svg'.
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<rect x="-50" y="-50" width="100" height="100" fill="#9F9F9F" transform="matrix(1,0,0,1,250,250)" />
<rect x="-50" y="-50" width="100" height="100" fill="#FF0000" transform="matrix(1,0,0,1,350,350)" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testCanvasBackground [
	| c y r file |
	c := RSCanvas new.
	r := Random new.
	c color: (Color colorFrom: '325A64').
	1 to: 500 do: [ :x|
		y := 255 + (x sin * 255).
		c addShape: (RSEllipse new
			color: Color transparent;
			border: (RSBorder new
				width: x/ 50;
				color: (Color 
					r: r next * 255 
					g: r next * 200
					b: 255
					range: y) );
			position: (x*2@y)-250;
			extent: (y/10)@( x * 75/ 499 ) ).
		 ].

	file := './test2.svg'.
	
	c svg2Exporter
		fileName: file;
		export.
	self assert: (file asFileReference contents includesSubstring: '325A64')
]

{ #category : #tests }
RSSVG2ExporterTest >> testEllipses [
	| c file |
	c := RSCanvas new.
	c addShape: (RSEllipse new
		extent: 100@100;
		yourself).
	c addShape: (RSEllipse new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	file := './test2.svg'.
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<ellipse cx="0" cy="0" rx="50" ry="50" fill="#9F9F9F" transform="matrix(1,0,0,1,250,250)" />
<ellipse cx="0" cy="0" rx="50" ry="50" fill="#FF0000" transform="matrix(1,0,0,1,350,350)" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testLabelWithBorder [
	| c file |
	c := RSCanvas new.
	c addShape: (RSLabel new
		fontSize: 60;
		fontName: 'Source Sans Pro';
		border: (RSBorder new 
			color: Color red;
			dashArray: #(4) );
		text: 'Roassal Pharo').
	file := './test2.svg'.
	
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<text style="font-family: ''Source Sans Pro''; font-size: 60px;" textLength="462.3199999999999" lengthAdjust="spacingAndGlyphs" transform="matrix(1,0,0,1,11.640000000000072,278.44)" fill="#808080" stroke="#FF0000" stroke-width="1" stroke-dasharray="4.0" stroke-dashoffset="0.0" >Roassal Pharo</text>
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testLabels [
	| c file |
	c := RSCanvas new.
	1 to: 12 do: [ :m | 
		| angle theta p label box |
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		label := RSLabel new
			color: (Color purple alpha: 0.5);
			fontName: 'Source Sans Pro';
			fontSize: 20;
			text: (Month nameOfMonth: m);
			yourself.
		angle := angle radiansToDegrees.
		angle := angle + ((angle between: 90 and: 270) 
			ifTrue: [ 180 ]
			ifFalse: [ 0 ] ).
		box := RSBox new
			fromRectangle: label encompassingRectangle;
			noPaint;
			withBorder;
			yourself.
		label rotateByDegrees: angle.
		label position: p + ((label textWidth/2) * theta).
		box rotateByDegrees: angle.
		box position: p + ((label textWidth/2) * theta).
			
		m even
			ifTrue: [ label bold ]
			ifFalse: [ label italic ].
		c addShape: box.
		c addShape: label.
		].
	c addShape: (RSEllipse new
		color: nil;
		withBorder;
		radius: 90).
	file := './test2.svg'.
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<rect x="-44.666666666666664" y="-16.9695" width="89.33333333333333" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.8660254037844387,0.49999999999999994,-0.49999999999999994,0.8660254037844387,375.2850084141488,322.3333333333333)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-style: italic;" textLength="89.33333333333333" lengthAdjust="spacingAndGlyphs" transform="matrix(0.8660254037844387,0.49999999999999994,-0.49999999999999994,0.8660254037844387,331.08737604464875,307.8992115048916)" fill="#660099" fill-opacity="0.4980392156862745" >January</text>
<rect x="-48.66666666666666" y="-16.9695" width="97.33333333333331" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.5000000000000003,0.8660254037844386,-0.8660254037844386,0.5000000000000003,324.33333333333337,378.7491100292865)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-weight: bold;" textLength="98.44416666666665" lengthAdjust="spacingAndGlyphs" transform="matrix(0.5000000000000003,0.8660254037844386,-0.8660254037844386,0.5000000000000003,290.2097468284418,338.8423244663426)" fill="#660099" fill-opacity="0.4980392156862745" >February</text>
<rect x="-32.199999999999996" y="-16.9695" width="64.39999999999999" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(-2.4492127076447545e-16,-1,1,-2.4492127076447545e-16,250.00000000000003,382.2)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-style: italic;" textLength="64.39999999999999" lengthAdjust="spacingAndGlyphs" transform="matrix(-2.4492127076447545e-16,-1,1,-2.4492127076447545e-16,259.59850000000006,416.79999999999995)" fill="#660099" fill-opacity="0.4980392156862745" >March</text>
<rect x="-25.400000000000002" y="-16.9695" width="50.800000000000004" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.5,-0.8660254037844386,0.8660254037844386,0.5,187.30000000000004,358.5995856345686)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-weight: bold;" textLength="51.91083333333334" lengthAdjust="spacingAndGlyphs" transform="matrix(0.5,-0.8660254037844386,0.8660254037844386,0.5,182.59483650489165,385.9461678660147)" fill="#660099" fill-opacity="0.4980392156862745" >April</text>
<rect x="-21.28" y="-16.9695" width="42.56" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.8660254037844384,-0.5000000000000004,0.5000000000000004,0.8660254037844384,144.96843902902327,310.64)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-style: italic;" textLength="42.56" lengthAdjust="spacingAndGlyphs" transform="matrix(0.8660254037844384,-0.5000000000000004,0.5000000000000004,0.8660254037844384,129.26020746740778,330.7925448382249)" fill="#660099" fill-opacity="0.4980392156862745" >May</text>
<rect x="-26.64" y="-16.9695" width="53.28" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(1,-2.4492127076447545e-16,2.4492127076447545e-16,1,123.36,250.00000000000003)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-weight: bold;" textLength="54.39083333333333" lengthAdjust="spacingAndGlyphs" transform="matrix(1,-2.4492127076447545e-16,2.4492127076447545e-16,1,95.33791666666667,259.59850000000006)" fill="#660099" fill-opacity="0.4980392156862745" >June</text>
<rect x="-22.706666666666667" y="-16.9695" width="45.413333333333334" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.8660254037844383,0.5,-0.5,0.8660254037844383,143.73290945295747,188.64666666666665)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-style: italic;" textLength="45.413333333333334" lengthAdjust="spacingAndGlyphs" transform="matrix(0.8660254037844383,0.5,-0.5,0.8660254037844383,118.5531949505637,185.1925448382249)" fill="#660099" fill-opacity="0.4980392156862745" >July</text>
<rect x="-38.36000000000001" y="-16.9695" width="76.72000000000001" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.4999999999999998,0.8660254037844388,-0.8660254037844388,0.4999999999999998,180.81999999999994,130.17672513238512)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-weight: bold;" textLength="77.83083333333335" lengthAdjust="spacingAndGlyphs" transform="matrix(0.4999999999999998,0.8660254037844388,-0.8660254037844388,0.4999999999999998,153.00974682844168,101.20495366789268)" fill="#660099" fill-opacity="0.4980392156862745" >August</text>
<rect x="-61.4" y="-16.9695" width="122.8" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(3.673819061467132e-16,1,-1,3.673819061467132e-16,249.99999999999997,88.6)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-style: italic;" textLength="122.8" lengthAdjust="spacingAndGlyphs" transform="matrix(3.673819061467132e-16,1,-1,3.673819061467132e-16,240.40149999999994,26.08)" fill="#660099" fill-opacity="0.4980392156862745" >September</text>
<rect x="-44.626666666666665" y="-16.9695" width="89.25333333333333" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.5,-0.8660254037844386,0.8660254037844386,0.5,322.31333333333333,124.74963260200259)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-weight: bold;" textLength="90.36416666666666" lengthAdjust="spacingAndGlyphs" transform="matrix(0.5,-0.8660254037844386,0.8660254037844386,0.5,307.34150317155826,169.87860312448916)" fill="#660099" fill-opacity="0.4980392156862745" >October</text>
<rect x="-57.199999999999996" y="-16.9695" width="114.39999999999999" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(0.8660254037844384,-0.5000000000000004,0.5000000000000004,0.8660254037844384,386.13919347491367,171.39999999999992)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-style: italic;" textLength="114.39999999999999" lengthAdjust="spacingAndGlyphs" transform="matrix(0.8660254037844384,-0.5000000000000004,0.5000000000000004,0.8660254037844384,339.3233294093611,209.51254483822487)" fill="#660099" fill-opacity="0.4980392156862745" >November</text>
<rect x="-56.01333333333333" y="-16.9695" width="112.02666666666666" height="33.939" fill="none" stroke="#808080" stroke-width="1" transform="matrix(1,-2.4492127076447545e-16,2.4492127076447545e-16,1,406.0133333333333,249.99999999999997)" />
<text style="font-family: ''Source Sans Pro''; font-size: 20px;font-weight: bold;" textLength="113.13749999999999" lengthAdjust="spacingAndGlyphs" transform="matrix(1,-2.4492127076447545e-16,2.4492127076447545e-16,1,347.0445833333333,259.5985)" fill="#660099" fill-opacity="0.4980392156862745" >December</text>
<ellipse cx="0" cy="0" rx="90" ry="90" fill="none" stroke="#808080" stroke-width="1" transform="matrix(1,0,0,1,250,250)" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testLabelsDona [
	| text canvas horizontal vertical groups count file |
	text := 'La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensiero

Sempre un amabile
Leggiadro viso
In pianto o in riso
È menzognero

La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensier
E di pensier
E di pensier

È sempre misero
Chi a lei s''affida
Chi le confida
Mal cauto il core

Pur mai non sentesi
Felice appieno
Chi su quel seno
Non liba amore

La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensier
E di pensier
E di pensier
'.
	count := 0.
	vertical := RSVerticalLineLayout new gapSize: 0.
	horizontal := RSHorizontalLineLayout new alignLabel.
	groups := (text splitOn: String cr,String cr) collect: [ :p | 
		| lines |
		lines := p lines collect: [ :line |
			| words boxes|
			words := (line splitOn: ' ') collect: [ :word | 
				RSLabel new
					text: word;
					ifNotNil: [ :lbl |
						word = 'donna' 
							ifTrue: [ lbl bold; fontSize: 14 ].
						word = 'misero' 
							ifTrue: [ lbl fontSize: 20; color: 'red' ].
						word = 'pensier'
							ifTrue: [ 
								lbl italic; underline; color: 'blue'; fontSize: (count*4)+10.
								count := count+1.  ]
						 ];
					yourself.
				].
			horizontal on: words.
			boxes := words collect: [ :lbl | 
				RSBox new
					fromRectangle: lbl encompassingRectangle;
					noPaint;
					withBorder;
					yourself ].
			(boxes, words)  asGroup asShape
				withBorder;
				padding: 5;
				yourself
			 ].
		vertical on: lines.
		
		lines asGroup asShape
			withBorder;
			padding: 5;
			yourself.
		].

	canvas := RSCanvas new.
	canvas addAll: groups.
	RSHorizontalFlowLayout new
		gapSize: 30;
		on: groups.
	canvas @ RSCanvasController.
	file := './test2.svg'.
	canvas svg2Exporter
		fileName: file;
		export.
	self 
		assert: (file asFileReference contents includesSubstring: '<text');
		assert: (file asFileReference contents includesSubstring: '<rect')
]

{ #category : #tests }
RSSVG2ExporterTest >> testLine [
	| c file s1 s2 |
	c := RSCanvas new.
	s1 := RSEllipse new
		size: 30;
		yourself.
	s2 := RSBox new
		size: 50;
		yourself.
	s2 translateTo: 200@200.
	c add: s1; add: s2.
	c add: (RSLine new
		attachPoint: (RSBorderAttachPoint new
			startOffset: 5;
			endOffset: 10;
			yourself);
		from: s1;
		to: s2;
		yourself).
	c nodes @ RSDraggable.
	c @ RSCanvasController.
	file := './test2.svg'.
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<ellipse cx="0" cy="0" rx="15" ry="15" fill="#9F9F9F" transform="matrix(1.875,0,0,1.875,53.125,53.125)" />
<rect x="-25" y="-25" width="50" height="50" fill="#9F9F9F" transform="matrix(1.875,0,0,1.875,428.125,428.125)" />
<line x1="79.64150429449553" y1="79.64150429449553" x2="367.9917478527522" y2="367.9917478527522" fill="none" stroke="#808080" stroke-width="1" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testLineWithMarkers [
	| c arrow axes circle dataLine file |
	c := RSCanvas new.
	arrow := RSPolygon new 
		points: { -10@0. 0@ -10. 10@0 };
		color: Color black;
		size: 10.
	circle := RSEllipse new
		radius: 2.5;
		color: Color red.
	axes := RSPolyline new
		controlPoints: { 10@10. 10@90. 90@90 }.
	dataLine := RSPolyline new 
		controlPoints: { 15@80. 29@50. 43@60. 57@30. 71@40. 85@15 }.
	axes markerEnd: (axes markerStart: arrow).
	dataLine marker: circle.
	axes model: 'Axes'.
	axes popup.
	dataLine model: 'Series'.
	dataLine popup.
	c addShape: axes.
	c addShape: dataLine.
	c camera zoomToFit: 250@250.
	file := './test2.svg'.
	c svg2Exporter
		fileName: file;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<polyline points="125,125  125,375  375,375  " fill="none" stroke="#808080" stroke-width="1" />
<polyline points="109.375,140.625 125,109.375 140.625,140.625 " fill="#000000" />
<polyline points="359.375,359.375 390.625,375 359.375,390.625 " fill="#000000" />
<polyline points="140.625,343.75  184.375,250  228.125,281.25  271.875,187.5  315.625,218.75  359.375,140.625  " fill="none" stroke="#808080" stroke-width="1" />
<ellipse cx="0" cy="0" rx="2.5" ry="2.5" fill="#FF0000" transform="matrix(-2.831822312485204,-1.3215170791597612,1.3215170791597612,-2.831822312485204,140.625,343.75)" />
<ellipse cx="0" cy="0" rx="2.5" ry="2.5" fill="#FF0000" transform="matrix(2.8318223124852047,1.3215170791597615,-1.3215170791597615,2.8318223124852047,184.375,250)" />
<ellipse cx="0" cy="0" rx="2.5" ry="2.5" fill="#FF0000" transform="matrix(-1.8163693553721758,2.5429170975210473,-2.5429170975210473,-1.8163693553721758,228.125,281.25)" />
<ellipse cx="0" cy="0" rx="2.5" ry="2.5" fill="#FF0000" transform="matrix(2.8318223124852047,1.3215170791597615,-1.3215170791597615,2.8318223124852047,271.875,187.5)" />
<ellipse cx="0" cy="0" rx="2.5" ry="2.5" fill="#FF0000" transform="matrix(-1.8163693553721758,2.5429170975210473,-2.5429170975210473,-1.8163693553721758,315.625,218.75)" />
<ellipse cx="0" cy="0" rx="2.5" ry="2.5" fill="#FF0000" transform="matrix(2.726581299842876,1.52688552791201,-1.52688552791201,2.726581299842876,359.375,140.625)" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]

{ #category : #tests }
RSSVG2ExporterTest >> testPathLabel [
	| c file |
	c := RSCanvas new.
	c addShape: (RSLabel new
		fontSize: 60;
		fontName: 'Source Sans Pro';
		border: (RSBorder new 
			color: Color red;
			dashArray: #(4) );
		text: 'Roassal Pharo').
	file := './test2.svg'.
	
	c svg2Exporter
		fileName: file;
		usePathLabel;
		export.
	self 
		assert: file asFileReference contents 
		equals: 
('<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" style="background-color:#FFFFFF" version="1.1">
<path d="M 7.20375 0.00140625 L 7.20375 -52.373594 L 23.594375 -52.373594 C 26.258437 -52.373594 28.727187 -52.115781 31.000625 -51.607969 C 33.270156 -51.09625 35.219375 -50.2525 36.844375 -49.076719 C 38.469375 -47.90875 39.735 -46.389219 40.64125 -44.514219 C 41.5475 -42.639219 42.000625 -40.342344 42.000625 -37.623594 C 42.000625 -33.506406 40.930312 -30.22125 38.7975 -27.764219 C 36.660781 -25.303281 33.781875 -23.623594 30.156875 -22.717344 L 43.51625 0.00140625 L 36.000625 0.00140625 L 23.36 -21.998594 L 13.844375 -21.998594 L 13.844375 0.00140625 Z M 13.844375 -27.451719 L 22.64125 -27.451719 C 26.742812 -27.451719 29.89125 -28.287656 32.07875 -29.967344 C 34.26625 -31.654844 35.36 -34.205625 35.36 -37.623594 C 35.36 -41.092344 34.26625 -43.518125 32.07875 -44.904844 C 29.89125 -46.299375 26.742812 -46.998594 22.64125 -46.998594 L 13.844375 -46.998594 Z M 67.207656 1.001406 C 64.801406 1.001406 62.512344 0.548281 60.348281 -0.357969 C 58.192031 -1.272031 56.285781 -2.600156 54.629531 -4.342344 C 52.981094 -6.080625 51.664687 -8.22125 50.676406 -10.764219 C 49.695937 -13.315 49.207656 -16.201719 49.207656 -19.420469 C 49.207656 -22.678281 49.695937 -25.584531 50.676406 -28.139219 C 51.664687 -30.69 52.981094 -32.84625 54.629531 -34.607969 C 56.285781 -36.3775 58.192031 -37.717344 60.348281 -38.623594 C 62.512344 -39.537656 64.801406 -39.998594 67.207656 -39.998594 C 69.602187 -39.998594 71.879531 -39.537656 74.035781 -38.623594 C 76.199844 -37.717344 78.106094 -36.3775 79.754531 -34.607969 C 81.410781 -32.84625 82.731094 -30.69 83.723281 -28.139219 C 84.711562 -25.584531 85.207656 -22.678281 85.207656 -19.420469 C 85.207656 -16.201719 84.711562 -13.315 83.723281 -10.764219 C 82.731094 -8.22125 81.410781 -6.080625 79.754531 -4.342344 C 78.106094 -2.600156 76.199844 -1.272031 74.035781 -0.357969 C 71.879531 0.548281 69.602187 1.001406 67.207656 1.001406 Z M 67.207656 -4.467344 C 68.852187 -4.467344 70.367812 -4.826719 71.754531 -5.545469 C 73.137344 -6.272031 74.324844 -7.287656 75.317031 -8.592344 C 76.305312 -9.904844 77.067031 -11.47125 77.598281 -13.295469 C 78.129531 -15.1275 78.395156 -17.170469 78.395156 -19.420469 C 78.395156 -21.670469 78.129531 -23.717344 77.598281 -25.561094 C 77.067031 -27.412656 76.305312 -29.006406 75.317031 -30.342344 C 74.324844 -31.686094 73.137344 -32.717344 71.754531 -33.436094 C 70.367812 -34.162656 68.852187 -34.529844 67.207656 -34.529844 C 65.551406 -34.529844 64.027969 -34.162656 62.645156 -33.436094 C 61.258437 -32.717344 60.070937 -31.686094 59.082656 -30.342344 C 58.090469 -29.006406 57.332656 -27.412656 56.801406 -25.561094 C 56.270156 -23.717344 56.004531 -21.670469 56.004531 -19.420469 C 56.004531 -17.170469 56.270156 -15.1275 56.801406 -13.295469 C 57.332656 -11.47125 58.090469 -9.904844 59.082656 -8.592344 C 60.070937 -7.287656 61.258437 -6.272031 62.645156 -5.545469 C 64.027969 -4.826719 65.551406 -4.467344 67.207656 -4.467344 Z M 104.395156 1.001406 C 101.145156 1.001406 98.434219 0.0365625 96.270156 -1.889219 C 94.113906 -3.815 93.035781 -6.549375 93.035781 -10.092344 C 93.035781 -14.381406 94.926406 -17.662656 98.707656 -19.936094 C 102.496719 -22.217344 108.555312 -23.811094 116.879531 -24.717344 C 116.879531 -25.943906 116.758437 -27.154844 116.520156 -28.342344 C 116.277969 -29.529844 115.863906 -30.576719 115.270156 -31.482969 C 114.684219 -32.389219 113.871719 -33.123594 112.832656 -33.686094 C 111.801406 -34.248594 110.481094 -34.529844 108.879531 -34.529844 C 106.637344 -34.529844 104.527969 -34.100156 102.551406 -33.248594 C 100.582656 -32.393125 98.824844 -31.428281 97.285781 -30.357969 L 94.723281 -34.936094 C 96.535781 -36.111875 98.746719 -37.248594 101.363906 -38.342344 C 103.977187 -39.443906 106.856094 -39.998594 110.004531 -39.998594 C 114.742812 -39.998594 118.180312 -38.53375 120.317031 -35.607969 C 122.449844 -32.69 123.520156 -28.795469 123.520156 -23.920469 L 123.520156 0.0326563 L 118.082656 0.0326563 L 117.520156 -4.639219 L 117.285781 -4.639219 C 115.410781 -3.084531 113.402969 -1.756406 111.270156 -0.654844 C 109.145156 0.446719 106.852187 1.001406 104.395156 1.001406 Z M 106.317031 -4.311094 C 108.180312 -4.311094 109.942031 -4.748594 111.598281 -5.623594 C 113.254531 -6.506406 115.012344 -7.811094 116.879531 -9.529844 L 116.879531 -20.389219 C 113.629531 -19.951719 110.895156 -19.436094 108.676406 -18.842344 C 106.465469 -18.256406 104.680312 -17.565 103.317031 -16.764219 C 101.961562 -15.959531 100.977187 -15.037656 100.363906 -13.998594 C 99.746719 -12.955625 99.442031 -11.811094 99.442031 -10.561094 C 99.442031 -8.318906 100.106094 -6.717344 101.442031 -5.748594 C 102.774062 -4.787656 104.399062 -4.311094 106.317031 -4.311094 Z M 145.918594 1.001406 C 143.145156 1.001406 140.504531 0.493594 137.996719 -0.514219 C 135.496719 -1.53375 133.309219 -2.818906 131.434219 -4.373594 L 134.715469 -8.811094 C 136.4225 -7.424375 138.168594 -6.299375 139.949844 -5.436094 C 141.738906 -4.568906 143.809219 -4.139219 146.152969 -4.139219 C 148.715469 -4.139219 150.637344 -4.725156 151.918594 -5.904844 C 153.199844 -7.080625 153.840469 -8.529844 153.840469 -10.248594 C 153.840469 -11.268125 153.574844 -12.154844 153.043594 -12.904844 C 152.512344 -13.662656 151.82875 -14.318906 150.996719 -14.873594 C 150.1725 -15.436094 149.223281 -15.928281 148.152969 -16.357969 C 147.090469 -16.795469 146.027969 -17.225156 144.965469 -17.654844 C 143.57875 -18.131406 142.188125 -18.678281 140.793594 -19.295469 C 139.406875 -19.90875 138.168594 -20.65875 137.074844 -21.545469 C 135.981094 -22.428281 135.082656 -23.459531 134.387344 -24.639219 C 133.699844 -25.815 133.356094 -27.232969 133.356094 -28.889219 C 133.356094 -30.451719 133.660781 -31.912656 134.277969 -33.279844 C 134.89125 -34.654844 135.770156 -35.834531 136.918594 -36.826719 C 138.063125 -37.815 139.465469 -38.592344 141.121719 -39.154844 C 142.777969 -39.717344 144.64125 -39.998594 146.715469 -39.998594 C 149.1725 -39.998594 151.426406 -39.565 153.481094 -38.701719 C 155.531875 -37.84625 157.301406 -36.803281 158.793594 -35.576719 L 155.684219 -31.404844 C 154.348281 -32.412656 152.957656 -33.240781 151.512344 -33.889219 C 150.074844 -34.53375 148.500625 -34.857969 146.793594 -34.857969 C 144.344375 -34.857969 142.5475 -34.295469 141.402969 -33.170469 C 140.254531 -32.045469 139.684219 -30.732969 139.684219 -29.232969 C 139.684219 -28.326719 139.9225 -27.53375 140.402969 -26.857969 C 140.879531 -26.178281 141.51625 -25.584531 142.309219 -25.076719 C 143.11 -24.565 144.031875 -24.107969 145.074844 -23.701719 C 146.113906 -23.303281 147.199844 -22.893125 148.324844 -22.467344 C 149.707656 -21.936094 151.106094 -21.373594 152.512344 -20.779844 C 153.926406 -20.193906 155.192031 -19.459531 156.309219 -18.576719 C 157.434219 -17.69 158.356094 -16.600156 159.074844 -15.311094 C 159.793594 -14.029844 160.152969 -12.482969 160.152969 -10.670469 C 160.152969 -9.053281 159.844375 -7.549375 159.231094 -6.154844 C 158.625625 -4.756406 157.719375 -3.522031 156.512344 -2.451719 C 155.313125 -1.389219 153.817031 -0.549375 152.027969 0.0639063 C 150.246719 0.688906 148.207656 1.001406 145.918594 1.001406 Z M 179.438125 1.001406 C 176.664687 1.001406 174.024062 0.493594 171.51625 -0.514219 C 169.01625 -1.53375 166.82875 -2.818906 164.95375 -4.373594 L 168.235 -8.811094 C 169.942031 -7.424375 171.688125 -6.299375 173.469375 -5.436094 C 175.258437 -4.568906 177.32875 -4.139219 179.6725 -4.139219 C 182.235 -4.139219 184.156875 -4.725156 185.438125 -5.904844 C 186.719375 -7.080625 187.36 -8.529844 187.36 -10.248594 C 187.36 -11.268125 187.094375 -12.154844 186.563125 -12.904844 C 186.031875 -13.662656 185.348281 -14.318906 184.51625 -14.873594 C 183.692031 -15.436094 182.742812 -15.928281 181.6725 -16.357969 C 180.61 -16.795469 179.5475 -17.225156 178.485 -17.654844 C 177.098281 -18.131406 175.707656 -18.678281 174.313125 -19.295469 C 172.926406 -19.90875 171.688125 -20.65875 170.594375 -21.545469 C 169.500625 -22.428281 168.602187 -23.459531 167.906875 -24.639219 C 167.219375 -25.815 166.875625 -27.232969 166.875625 -28.889219 C 166.875625 -30.451719 167.180312 -31.912656 167.7975 -33.279844 C 168.410781 -34.654844 169.289687 -35.834531 170.438125 -36.826719 C 171.582656 -37.815 172.985 -38.592344 174.64125 -39.154844 C 176.2975 -39.717344 178.160781 -39.998594 180.235 -39.998594 C 182.692031 -39.998594 184.945937 -39.565 187.000625 -38.701719 C 189.051406 -37.84625 190.820937 -36.803281 192.313125 -35.576719 L 189.20375 -31.404844 C 187.867812 -32.412656 186.477187 -33.240781 185.031875 -33.889219 C 183.594375 -34.53375 182.020156 -34.857969 180.313125 -34.857969 C 177.863906 -34.857969 176.067031 -34.295469 174.9225 -33.170469 C 173.774062 -32.045469 173.20375 -30.732969 173.20375 -29.232969 C 173.20375 -28.326719 173.442031 -27.53375 173.9225 -26.857969 C 174.399062 -26.178281 175.035781 -25.584531 175.82875 -25.076719 C 176.629531 -24.565 177.551406 -24.107969 178.594375 -23.701719 C 179.633437 -23.303281 180.719375 -22.893125 181.844375 -22.467344 C 183.227187 -21.936094 184.625625 -21.373594 186.031875 -20.779844 C 187.445937 -20.193906 188.711562 -19.459531 189.82875 -18.576719 C 190.95375 -17.69 191.875625 -16.600156 192.594375 -15.311094 C 193.313125 -14.029844 193.6725 -12.482969 193.6725 -10.670469 C 193.6725 -9.053281 193.363906 -7.549375 192.750625 -6.154844 C 192.145156 -4.756406 191.238906 -3.522031 190.031875 -2.451719 C 188.832656 -1.389219 187.336562 -0.549375 185.5475 0.0639063 C 183.76625 0.688906 181.727187 1.001406 179.438125 1.001406 Z M 211.754531 1.001406 C 208.504531 1.001406 205.793594 0.0365625 203.629531 -1.889219 C 201.473281 -3.815 200.395156 -6.549375 200.395156 -10.092344 C 200.395156 -14.381406 202.285781 -17.662656 206.067031 -19.936094 C 209.856094 -22.217344 215.914687 -23.811094 224.238906 -24.717344 C 224.238906 -25.943906 224.117812 -27.154844 223.879531 -28.342344 C 223.637344 -29.529844 223.223281 -30.576719 222.629531 -31.482969 C 222.043594 -32.389219 221.231094 -33.123594 220.192031 -33.686094 C 219.160781 -34.248594 217.840469 -34.529844 216.238906 -34.529844 C 213.996719 -34.529844 211.887344 -34.100156 209.910781 -33.248594 C 207.942031 -32.393125 206.184219 -31.428281 204.645156 -30.357969 L 202.082656 -34.936094 C 203.895156 -36.111875 206.106094 -37.248594 208.723281 -38.342344 C 211.336562 -39.443906 214.215469 -39.998594 217.363906 -39.998594 C 222.102187 -39.998594 225.539687 -38.53375 227.676406 -35.607969 C 229.809219 -32.69 230.879531 -28.795469 230.879531 -23.920469 L 230.879531 0.0326563 L 225.442031 0.0326563 L 224.879531 -4.639219 L 224.645156 -4.639219 C 222.770156 -3.084531 220.762344 -1.756406 218.629531 -0.654844 C 216.504531 0.446719 214.211562 1.001406 211.754531 1.001406 Z M 213.676406 -4.311094 C 215.539687 -4.311094 217.301406 -4.748594 218.957656 -5.623594 C 220.613906 -6.506406 222.371719 -7.811094 224.238906 -9.529844 L 224.238906 -20.389219 C 220.988906 -19.951719 218.254531 -19.436094 216.035781 -18.842344 C 213.824844 -18.256406 212.039687 -17.565 210.676406 -16.764219 C 209.320937 -15.959531 208.336562 -15.037656 207.723281 -13.998594 C 207.106094 -12.955625 206.801406 -11.811094 206.801406 -10.561094 C 206.801406 -8.318906 207.465469 -6.717344 208.801406 -5.748594 C 210.133437 -4.787656 211.758437 -4.311094 213.676406 -4.311094 Z M 250.074844 1.001406 C 247.574844 1.001406 245.785781 0.255313 244.715469 -1.232969 C 243.652969 -2.732969 243.121719 -4.924375 243.121719 -7.811094 L 243.121719 -56.998594 L 249.684219 -56.998594 L 249.684219 -7.342344 C 249.684219 -6.279844 249.863906 -5.53375 250.231094 -5.107969 C 250.606094 -4.678281 251.031875 -4.467344 251.512344 -4.467344 C 251.731094 -4.467344 251.934219 -4.467344 252.121719 -4.467344 C 252.309219 -4.467344 252.590469 -4.518125 252.965469 -4.623594 L 253.840469 0.360781 C 253.410781 0.567813 252.902969 0.724063 252.309219 0.829531 C 251.723281 0.942813 250.981094 1.001406 250.074844 1.001406 Z M 280.164687 0.00140625 L 280.164687 -52.998594 L 295.117812 -52.998594 C 298.055312 -52.998594 300.735 -52.725156 303.164687 -52.186094 C 305.590469 -51.643125 307.652969 -50.768125 309.352187 -49.561094 C 311.059219 -48.350156 312.39125 -46.748594 313.352187 -44.748594 C 314.320937 -42.756406 314.805312 -40.311094 314.805312 -37.404844 C 314.805312 -34.611875 314.336562 -32.19 313.399062 -30.139219 C 312.469375 -28.084531 311.152969 -26.389219 309.445937 -25.045469 C 307.735 -23.701719 305.695937 -22.69 303.320937 -22.014219 C 300.945937 -21.334531 298.320937 -20.998594 295.445937 -20.998594 L 286.805312 -20.998594 L 286.805312 0.00140625 Z M 286.805312 -26.467344 L 294.649062 -26.467344 C 299.231094 -26.467344 302.625625 -27.342344 304.836562 -29.092344 C 307.055312 -30.850156 308.164687 -33.623594 308.164687 -37.404844 C 308.164687 -41.236875 307.000625 -43.897031 304.680312 -45.389219 C 302.356094 -46.8775 298.902969 -47.623594 294.320937 -47.623594 L 286.805312 -47.623594 Z M 324.801406 0.00140625 L 324.801406 -57.186094 L 331.363906 -57.186094 L 331.363906 -41.607969 L 331.113906 -33.576719 C 332.988906 -35.334531 334.934219 -36.84625 336.957656 -38.107969 C 338.988906 -39.365781 341.363906 -39.998594 344.082656 -39.998594 C 348.184219 -39.998594 351.184219 -38.709531 353.082656 -36.139219 C 354.977187 -33.565 355.926406 -29.764219 355.926406 -24.732969 L 355.926406 0.00140625 L 349.363906 0.00140625 L 349.363906 -23.857969 C 349.363906 -27.545469 348.774062 -30.205625 347.598281 -31.842344 C 346.418594 -33.475156 344.555312 -34.295469 342.004531 -34.295469 C 339.973281 -34.295469 338.180312 -33.78375 336.629531 -32.764219 C 335.086562 -31.740781 333.332656 -30.240781 331.363906 -28.264219 L 331.363906 0.00140625 Z M 377.274062 1.001406 C 374.024062 1.001406 371.313125 0.0365625 369.149062 -1.889219 C 366.992812 -3.815 365.914687 -6.549375 365.914687 -10.092344 C 365.914687 -14.381406 367.805312 -17.662656 371.586562 -19.936094 C 375.375625 -22.217344 381.434219 -23.811094 389.758437 -24.717344 C 389.758437 -25.943906 389.637344 -27.154844 389.399062 -28.342344 C 389.156875 -29.529844 388.742812 -30.576719 388.149062 -31.482969 C 387.563125 -32.389219 386.750625 -33.123594 385.711562 -33.686094 C 384.680312 -34.248594 383.36 -34.529844 381.758437 -34.529844 C 379.51625 -34.529844 377.406875 -34.100156 375.430312 -33.248594 C 373.461562 -32.393125 371.70375 -31.428281 370.164687 -30.357969 L 367.602187 -34.936094 C 369.414687 -36.111875 371.625625 -37.248594 374.242812 -38.342344 C 376.856094 -39.443906 379.735 -39.998594 382.883437 -39.998594 C 387.621719 -39.998594 391.059219 -38.53375 393.195937 -35.607969 C 395.32875 -32.69 396.399062 -28.795469 396.399062 -23.920469 L 396.399062 0.0326563 L 390.961562 0.0326563 L 390.399062 -4.639219 L 390.164687 -4.639219 C 388.289687 -3.084531 386.281875 -1.756406 384.149062 -0.654844 C 382.024062 0.446719 379.731094 1.001406 377.274062 1.001406 Z M 379.195937 -4.311094 C 381.059219 -4.311094 382.820937 -4.748594 384.477187 -5.623594 C 386.133437 -6.506406 387.89125 -7.811094 389.758437 -9.529844 L 389.758437 -20.389219 C 386.508437 -19.951719 383.774062 -19.436094 381.555312 -18.842344 C 379.344375 -18.256406 377.559219 -17.565 376.195937 -16.764219 C 374.840469 -15.959531 373.856094 -15.037656 373.242812 -13.998594 C 372.625625 -12.955625 372.320937 -11.811094 372.320937 -10.561094 C 372.320937 -8.318906 372.985 -6.717344 374.320937 -5.748594 C 375.652969 -4.787656 377.277969 -4.311094 379.195937 -4.311094 Z M 408.64125 0.00140625 L 408.64125 -39.029844 L 414.07875 -39.029844 L 414.64125 -31.951719 L 414.875625 -31.951719 C 416.207656 -34.40875 417.820937 -36.361875 419.719375 -37.811094 C 421.613906 -39.268125 423.680312 -39.998594 425.9225 -39.998594 C 427.461562 -39.998594 428.848281 -39.725156 430.07875 -39.186094 L 428.7975 -33.404844 C 428.160781 -33.623594 427.570937 -33.78375 427.031875 -33.889219 C 426.500625 -33.990781 425.832656 -34.045469 425.031875 -34.045469 C 423.383437 -34.045469 421.664687 -33.373594 419.875625 -32.029844 C 418.094375 -30.693906 416.535781 -28.365781 415.20375 -25.045469 L 415.20375 0.00140625 Z M 451.527969 1.001406 C 449.121719 1.001406 446.832656 0.548281 444.668594 -0.357969 C 442.512344 -1.272031 440.606094 -2.600156 438.949844 -4.342344 C 437.301406 -6.080625 435.985 -8.22125 434.996719 -10.764219 C 434.01625 -13.315 433.527969 -16.201719 433.527969 -19.420469 C 433.527969 -22.678281 434.01625 -25.584531 434.996719 -28.139219 C 435.985 -30.69 437.301406 -32.84625 438.949844 -34.607969 C 440.606094 -36.3775 442.512344 -37.717344 444.668594 -38.623594 C 446.832656 -39.537656 449.121719 -39.998594 451.527969 -39.998594 C 453.9225 -39.998594 456.199844 -39.537656 458.356094 -38.623594 C 460.520156 -37.717344 462.426406 -36.3775 464.074844 -34.607969 C 465.731094 -32.84625 467.051406 -30.69 468.043594 -28.139219 C 469.031875 -25.584531 469.527969 -22.678281 469.527969 -19.420469 C 469.527969 -16.201719 469.031875 -13.315 468.043594 -10.764219 C 467.051406 -8.22125 465.731094 -6.080625 464.074844 -4.342344 C 462.426406 -2.600156 460.520156 -1.272031 458.356094 -0.357969 C 456.199844 0.548281 453.9225 1.001406 451.527969 1.001406 Z M 451.527969 -4.467344 C 453.1725 -4.467344 454.688125 -4.826719 456.074844 -5.545469 C 457.457656 -6.272031 458.645156 -7.287656 459.637344 -8.592344 C 460.625625 -9.904844 461.387344 -11.47125 461.918594 -13.295469 C 462.449844 -15.1275 462.715469 -17.170469 462.715469 -19.420469 C 462.715469 -21.670469 462.449844 -23.717344 461.918594 -25.561094 C 461.387344 -27.412656 460.625625 -29.006406 459.637344 -30.342344 C 458.645156 -31.686094 457.457656 -32.717344 456.074844 -33.436094 C 454.688125 -34.162656 453.1725 -34.529844 451.527969 -34.529844 C 449.871719 -34.529844 448.348281 -34.162656 446.965469 -33.436094 C 445.57875 -32.717344 444.39125 -31.686094 443.402969 -30.342344 C 442.410781 -29.006406 441.652969 -27.412656 441.121719 -25.561094 C 440.590469 -23.717344 440.324844 -21.670469 440.324844 -19.420469 C 440.324844 -17.170469 440.590469 -15.1275 441.121719 -13.295469 C 441.652969 -11.47125 442.410781 -9.904844 443.402969 -8.592344 C 444.39125 -7.287656 445.57875 -6.272031 446.965469 -5.545469 C 448.348281 -4.826719 449.871719 -4.467344 451.527969 -4.467344 Z M 473.199844 0.00140625 " transform="matrix(1,0,0,1,11.640000000000072,278.44)" fill="#808080" stroke="#FF0000" stroke-width="1" stroke-dasharray="4.0" stroke-dashoffset="0.0" />
</svg>' copyReplaceAll: String cr with: String crlf).
	
]
