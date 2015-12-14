program opalArmStability
	version 14
	args path armLengthMetres
	
	import delimited using `path', encoding(ISO-8859-1)
	format time %16.0f
	
	keep time samplecount v54 v55
	
	rename v54 angularVelocityYRads
	rename v55 angularVelocityZRads
	
	g linearVelocityYMetres = angularVelocityYRads * `armLengthMetres'
	label variable linearVelocityYMetres "Linear velocity Y (m/s)"
	g linearVelocityZMetres = angularVelocityZRads * `armLengthMetres'
	label variable linearVelocityZMetres "Linear velocity Z (m/s)"
	
	twoway line linearVelocityZMetres linearVelocityYMetres

end
