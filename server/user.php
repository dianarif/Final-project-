<?php
// Create connection
$con = mysqli_connect("db.sice.indiana.edu","i494f19_team05","my+sql=i494f19_team05","i494f19_team05");

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// Select all of our stocks from table 'user'
$sql = "SELECT * FROM user";

// Confirm there are results
if ($result = mysqli_query($con, $sql))
{
        // We have results, create an array to hold the results and an array to hold the data
        $resultArray = array();
        $tempArray = array();

        // Loop through each result
        while($row = $result->fetch_object())
        {
                // Add each result into the results array
                $tempArray = $row;
        array_push($resultArray, $tempArray);
        }

        // Encode the array to JSON and output the results
        echo json_encode($resultArray);
}

// Close connections
mysqli_close($con);
?>
