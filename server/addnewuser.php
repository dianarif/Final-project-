<?php
	$secret = $_POST["secretWord"];
	if ("44fdcv8jf3" != $secret) exit; // note the same secret as the app - could be let out if this check is not required. secretWord is not entered by the user and is used to prevent unauthorized access to the database
	
	$first_name = $_POST['first_name'];
	$last_name = $_POST['last_name'];
	$email = $_POST['email'];
	$dob = $_POST['dob'];
	$phone = $_POST['phone'];
	
// POST items should be checked for bad information before being added to the database.

// Create connection
	$mysqli=mysqli_connect("db.sice.indiana.edu","i494f19_team05","my+sql=i494f19_team05","i494f19_team05"); // localhost, user name, user password, database name
 
// Check connection
	if (mysqli_connect_errno())
	{
	  echo "Failed to connect to MySQL: ". mysqli_connect_error();
	}
	
	$query = "INSERT INTO 'user' (item1, item2, item3, item4, item5) value ('".$item1."','".$item2."','".$item3."','".$item4."','".$item5."')";
	$result = mysqli_query($mysqli,$query);

	echo $result; // sends 1 if insert worked
?>