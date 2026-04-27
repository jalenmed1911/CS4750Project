<?php
    session_start();
    //require("transferportaldb.php"); Not needed
?>

<!DOCTYPE html>
<html>
    <head>
        <title>Transfer Portal</title>
        <link rel="stylesheet" href="createAccount.css"> <!--Need to Change this for clarity-->
    </head>

<!--REMEMBER TO CHANGE THE NAMME EXPECTED IN THE INDEX.PHP FILE (Status: Handled. dont worry about this)-->
    <body>
        <div class="create-account-container">
            <h2>Create A Transfer Portal Account</h2>

            <!--Create Account Form:-->
            <!--EXPLANATION OF CREATE ACCOUNT FORM:
                form method: post -> Tells html to send data to the server
                form action: index.php -> Sends content to index.php
                form enctype: application/x-www-form-urlencoded -> Tells html to send the data in a url encoded format(which is the default)
                button type: submit -> Tells html to submit the form
                (ie tells html that the content of the form is done and ready to be sent to the server)
            -->
            <form method="post" action="index.php" enctype="application/x-www-form-urlencoded">
                
                <!--Username input:-->
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="Create_Account_Username" required>
                </div>

                <!--Password input:-->
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="Create_Account_Password" required>
                </div>

                <!--Create Account button:-->
                <button type="submit" name="Account_Creation">Create Account</button>
            </form>

            <!--Return to Login button:-->
            <!--EXPLANATION OF RETURN TO LOGIN FORM:
                form method: post -> Tells html to send data to the server
                form action: index.php -> Sends content to index.php
                form enctype: application/x-www-form-urlencoded -> Tells html to send the data in a url encoded format(which is the default)
                
                button type: submit -> Tells html to submit the form
                (ie tells html that the content of the form is done and ready to be sent to the server)
            -->
            <form method="post" action="index.php" enctype="application/x-www-form-urlencoded">
                <button type="submit" name="Return_To_Login" style="margin-top: 10px;">Return to Login</button>
            </form>


            <!-- Failure cases:
                (happens when account creation was unsuccessful)
            -->
            <?php 
                if (isset($_SESSION['error'])) { 
                    echo '<p class="error" style="color: red;">' . htmlspecialchars($_SESSION['error']) . '</p>'; 
                    unset($_SESSION['error']);
                }
            ?>
            
        </div>
    </body>
</html>
