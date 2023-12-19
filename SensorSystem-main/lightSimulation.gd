extends Node3D

var time = {"hours":0,"minutes":0,"seconds":0.0}
var time_rate = 1
var starter_val = -3

var inc_1:float = 0.0
var inc_2:float =0.0

var dec_1:float = 1.0
var dec_2:float = 1.0

var min_1 = 3
var max_1 = 6

var min_2 = 6
var max_2 = 12


var prev_time

var is_afternoon:bool = false

@onready var env = $world.environment
@onready var slider = $Control.get_node("slider")
@onready var label = $Control.get_node("Label")
@onready var li = $light

func log10base(value):
	return log(value)/log(10)


func set_time(seconds_passed,time_rate):
	var prev_sec = time["seconds"]
	var prev_min = time["minutes"]
	
	time["seconds"] = wrap(time["seconds"]+seconds_passed*time_rate,0.0,60.0)
	
	if prev_sec>=time["seconds"]:
		time["minutes"] = wrap(time["minutes"]+1,0,60)
		
	if prev_min>=time["minutes"] and prev_min!=time["minutes"]: 
		time["hours"] =  wrap(time["hours"]+1,0,24)
	
func get_time(unit:String):
	return time[unit]


func _ready():
	li.light_intensity_lux = 0
	env.background_intensity = 0
	

func _physics_process(delta):
	#you can adjust the rate time passes with adjusting the slider
	time_rate = slider.value
	#sets all the values for the hours, minutes and seconds respectably to be integers
	#that can be displayed on screen
	var prev_min = get_time("minutes")
	set_time(delta,time_rate)
	
	#display the values on the UI 
	label.set_text("%s:" % floor(time["hours"]) + "%s:" % time["minutes"] + "%s" % floor(time["seconds"]))
	
	if get_time("hours") >= min_1 and get_time("hours")<max_1:
		#if a minute passes calculate the luminosity of light 
		if prev_min!=get_time("minutes"):
			inc_1 += float(1.0/180.0)
			print(pow(10,lerp(-3,3,inc_1)))
			li.light_intensity_lux = pow(10,lerp(-3,3,inc_1))
			env.background_intensity = pow(10,lerp(-3,3,inc_1))
	
	if  get_time("hours")>=min_2 and get_time("hours")<max_2:
		if prev_min!=get_time("minutes"):
			inc_2 += float(1.0/360)
			#print(pow(10,lerp(3,5,inc_2)))
			li.light_intensity_lux = pow(10,lerp(3,5,inc_2))
			env.background_intensity = pow(10,lerp(3,5,inc_2))
	
	if get_time("hours") >= 18 and get_time("hours")<20:
		#if a minute passes calculate the luminosity of light 
		if prev_min!=get_time("minutes"):
			dec_2 -= float(1.0/120.0)
			#print(pow(10,lerp(-3,3,dec_2)))
			li.light_intensity_lux = pow(10,lerp(-3,3,dec_2))
			env.background_intensity = pow(10,lerp(-3,3,dec_2))
	
	if  get_time("hours")>=12 and get_time("hours")<18:
		if prev_min!=get_time("minutes"):
			dec_1 -= float(1.0/360)
			#print(pow(10,lerp(3,5,dec_1)))
			li.light_intensity_lux = pow(10,lerp(3,5,dec_1))
			env.background_intensity = pow(10,lerp(3,5,dec_1))
	
	
			
			
			
#
		
	
	
