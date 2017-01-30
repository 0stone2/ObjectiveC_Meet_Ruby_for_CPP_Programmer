=begin 
Ruby (Sample03.rb)코드입니다.
=end

def myfunc_0 ()
	$szWhoamI = "myfunc_0"
end

def myfunc_1 ()
	$szWhoamI = "myfunc_1"
	return
end

def myfunc_2 ()
	$szWhoamI= "myfunc_2"
	return "Success"
end

def myfunc_3 ()
	$szWhoamI = "myfunc_3"
	return ["Success", true]
end

def myfunc_4 (szMyName)
	$szWhoamI = szMyName
	return ["Success", true]
end

def myfunc_5 (szMyName, bReturnValue)
	$szWhoamI = szMyName
	return ["Success", bReturnValue]
end

$szWelcomMessage = "Hello World"
$szWhoamI = "Sample03.rb"