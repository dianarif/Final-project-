<?php
        echo "upload license php";
        echo "      ";

        //$secret = $_POST["secretWord"];
        //if ("44fdcv8jf3" != $secret) exit; // note the same secret as the app - could be let out if this check is not required. secretWord is not entered by the user and is used to prevent unauthorized access to the database

echo "the code secretword is success";
echo "         ";

        $license_number = $_POST['license_number'];
        $exp_date = $_POST['exp_date'];
        $license_photo = $_POST['license_photo'];

echo "managed to post license number and exp date";
echo "          ";
echo $exp_date;
echo "         ";

        // POST items should be checked for bad information before being added to the database.

        // Create connection
        $mysqli=mysqli_connect("db.sice.indiana.edu","i494f19_team05","my+sql=i494f19_team05","i494f19_team05"); // localhost, user name, user password, database name


        // Check connection
        if (mysqli_connect_errno())
        {
          echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }


        $uploaddir = "./uploads/";

        $file = basename($_FILES['file']['name']);

                echo "file path works";
                echo "          ";

        $uploadfile = $uploaddir . $file;

                echo "upload file works";
                echo "           ";
                echo $file;
                echo "        ";
                echo $uploadfile;

                if(!(getimagesize($_FILES["file"]["tmp_name"]) !== false))
                {
                        echo "Sorry, your image is invalid";
                        exit;
                }

                if (file_exists("./uploads/"))
                {
                        echo " folder exist   ";
                }
				
				echo "    ";
                print_r($_FILES);

                if (move_uploaded_file($_FILES["file"]["tmp_name"], $uploadfile))
                {
                        echo "Successfully";
                }
                else
                {
                        echo "Sorry, there was an error uploading your file.";
                }


        $query = "";
        $result = mysqli_query($mysqli,$query);

        echo $result; // sends 1 if insert worked

?>