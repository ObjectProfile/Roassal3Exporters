"
TODO
"
Class {
	#name : #RSVideoExporter,
	#superclass : #RSRoassalExporter,
	#instVars : [
		'timer',
		'fps',
		'step',
		'maxIndex',
		'tempFiles',
		'shouldRemoveTempDir',
		'fpsOutput',
		'duration',
		'hasTransparency'
	],
	#classVars : [
		'ffmpegPath'
	],
	#category : #'Roassal3-Exporters-Video'
}

{ #category : #accessing }
RSVideoExporter class >> extension [
	^ 'mp4'
]

{ #category : #public }
RSVideoExporter class >> ffmpegPath [
	^ ffmpegPath ifNil: [ ffmpegPath := self resolveffmpegPath ].
]

{ #category : #accessing }
RSVideoExporter class >> inspectCommand [
	<script>
	^ self new fullCommand inspect
]

{ #category : #public }
RSVideoExporter class >> resolveffmpegPath [
	"Intall ffmepg in your computer with
	`xcode-select --install` or `brew install ffmpeg` in your terminal.
	
	OSSUnixSubprocess works on mac linux, windows users need to wait or submit an issue in roassal3 githubpage 
	"
	^ OSSUnixSubprocess new
		command: '/usr/bin/which';
		arguments: (Array with: 'ffmpeg');
		addAllEnvVariablesFromParentWithoutOverride;
		redirectStdout;
		terminateOnShutdown;
		runAndWaitOnExitDo: [ :process :outString :errString | 
			^ process isSuccess 
				ifTrue: [ outString trim ]
				ifFalse: [ self error: 'ffmpeg not found' ]
			]
]

{ #category : #accessing }
RSVideoExporter >> duration [
	^ duration ifNil: [ duration := self durationFromCanvas ].
]

{ #category : #accessing }
RSVideoExporter >> duration: aDuration [
	duration := aDuration
]

{ #category : #accessing }
RSVideoExporter >> durationFromCanvas [
	| maxDuration |
	maxDuration := 0 seconds.
	canvas animations do: [ :a |
		maxDuration := maxDuration max: a duration ].
	^ maxDuration
]

{ #category : #private }
RSVideoExporter >> exportFrame: index [
	| name |
	name := self nameFor: index.
	canvas pngExporter
		noDoubleDraw;
		fileName: (tempFiles / name) pathString ;
		export.
	timer addTime: step milliSeconds.
]

{ #category : #private }
RSVideoExporter >> exportToDirectory: directory [
	| oldTimer e |
	tempFiles := directory.
	oldTimer := canvas timer.
	e := canvas extent.
	e y even ifTrue: [ canvas extent: e x @ (e y - 1)  ].
	timer := RSVariableTimer new.
	step := 1000.0 / fps.
	canvas timer: timer.
	maxIndex := fps * (self duration asSeconds max: 1).
	(1 to: maxIndex) do: [ :index |
		self exportFrame: index
	] displayingProgress: [:i | 'Rendering ', i asString,'/', maxIndex asString ].
	canvas timer: oldTimer.
]

{ #category : #public }
RSVideoExporter >> exportToFile: file [
	| firstTime |
	'Video exporting Started: ' trace.
	firstTime := Time now traceCr.
	self exportToDirectory: (file parent / file path base) createDirectory.
	self exportWithffmpeg: file.
	'Ended: ' trace.
	Time now traceCr.
	'Duration: ' trace.
	(Time now asDuration - firstTime asDuration) traceCr
]

{ #category : #private }
RSVideoExporter >> exportWithffmpeg: file [
	self newProcess
		runAndWaitOnExitDo: [ :process :outString :errString |
		process isSuccess ifTrue: [ 
			self extension,' file created!' traceCr.
			shouldRemoveTempDir ifTrue: [ tempFiles deleteAll ].
			 ]
		ifFalse: [
			('Command exit with error status: ', process exitStatusInterpreter printString) traceCr.
			('Stderr contents: ', errString) traceCr 
		]
	].
]

{ #category : #accessing }
RSVideoExporter >> extension [
	^ hasTransparency 
		ifTrue: [ 'mov' ]
		ifFalse: [ 'mp4' ]
]

{ #category : #public }
RSVideoExporter >> fps120 [
	self fps: 120
]

{ #category : #public }
RSVideoExporter >> fps60 [
	self fps: 60
]

{ #category : #public }
RSVideoExporter >> fps: aNumber [
	aNumber < 1 ifTrue: [ self error: 'invalid fps' ].
	fps := aNumber.
	fpsOutput := aNumber.
]

{ #category : #public }
RSVideoExporter >> fpsOutPut: aNumber [
	aNumber < 1 ifTrue: [ self error: 'invalid fps' ].
	fpsOutput := aNumber.
]

{ #category : #accessing }
RSVideoExporter >> framesDirectory: aFile [
	tempFiles := aFile.
	self keepTempDir
]

{ #category : #accessing }
RSVideoExporter >> fullCommand [
	^ String streamContents: [ :stream |
		stream << 'ffmpeg '.
		self processArguments do: [ :each |
			(each includes: $*)
				ifTrue: [ stream << '"' << each << '"' ]
				ifFalse: [ stream << each ].
			] separatedBy: [ stream space ].
		 ]
]

{ #category : #initialization }
RSVideoExporter >> initialize [
	super initialize.
	self removeTempDir.
	self fps60.
	self opaque.
	
]

{ #category : #public }
RSVideoExporter >> keepTempDir [
	shouldRemoveTempDir := false
]

{ #category : #accessing }
RSVideoExporter >> nameFor: index [
	^ String streamContents: [ :s |
		maxIndex decimalDigitLength - index decimalDigitLength 
			timesRepeat: [ s<<'0' ].
		index printOn: s
		 ].
]

{ #category : #private }
RSVideoExporter >> newProcess [
	^ OSSUnixSubprocess new
		command: self class ffmpegPath;
		arguments: self processArguments;
		workingDirectory: tempFiles fullName;
		addAllEnvVariablesFromParentWithoutOverride;
		redirectStdout;
		redirectStderr;
		terminateOnShutdown;
		yourself
]

{ #category : #public }
RSVideoExporter >> opaque [
	"will produce mp4 videos"
	hasTransparency := false
	
]

{ #category : #public }
RSVideoExporter >> p1080 [
	"Full HD"
	canvas extent: 1920@1080
]

{ #category : #public }
RSVideoExporter >> p2160 [
	"Ultra-HD (4K)"
	canvas extent: 3860@2160
]

{ #category : #public }
RSVideoExporter >> p480 [
	canvas extent: 858@480 
]

{ #category : #public }
RSVideoExporter >> p720 [
	"Half HD"
	canvas extent: 1280@720
]

{ #category : #private }
RSVideoExporter >> processArguments [
	| args |
	args := OrderedCollection new
		add:'-framerate';
		add: fpsOutput asString;
		add: '-pattern_type';
		add: 'glob';
		add: '-i';
		add: '*.png';
		yourself.
	
	hasTransparency ifTrue: [ 
		"-vcodec prores_ks -pix_fmt yuva444p10le -profile:v 4444"
		args
			add: '-vcodec';
			add: 'prores_ks';
			add: '-pix_fmt';
			add: 'yuva444p10le';
			add: '-profile:v';
			add: '4444' ]
	ifFalse: [ 
		"-framerate 30 -pattern_type glob -i *.png -c:v libx264 -pix_fmt yuv420p".
		args
			add: '-c:v';
			add: 'libx264';
			add: '-pix_fmt';
			add: 'yuv420p'. ].
	args add: '../', self baseName.
	^ args asArray.
]

{ #category : #public }
RSVideoExporter >> removeTempDir [
	shouldRemoveTempDir := true
]

{ #category : #public }
RSVideoExporter >> transparent [
	"will produce mov videos with transparency.
	Warning use this videos to post creation to another video, not the final video.
	These mov files has occupy a lot space on disk, even just a few seconds"
	hasTransparency := true
	
]
