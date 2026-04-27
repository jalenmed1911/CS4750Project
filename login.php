<?php
    session_start();
    //require("transferportaldb.php"); Not needed
?>

<!DOCTYPE html>
<html>
    <head>
        <title>Transfer Portal</title>
        <link rel="stylesheet" href="login.css">
    </head>
    <body>
        <div class="login-container">
            <h2>Transfer Portal Login</h2>
            <!-- Login form: -->
            <!--  EXPLANATION OF LOGIN FORM:
                form method: post -> Tells html to send data to the server
                form action: index.php -> Sends content to index.php
                form enctype: application/x-www-form-urlencoded -> Tells html to send the data in a url encoded format(which is the default)
                button type: submit -> Tells html to submit the form
                    (ie tells html that the content of the form is done and ready to be sent to the server)
            -->    
            <form method="post" action="index.php" enctype="application/x-www-form-urlencoded">
                
                <!-- Username input: -->
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>
                <!-- Password input: -->
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>

                <!-- Sign in button: -->

                <button type="submit">Sign In</button>
            </form>

            <!-- Create account button: -->
            <!--EXPLANATION OF CREATE ACCOUNT FORM:
                form method: post -> Tells html to send data to the server
                form action: index.php -> Sends content to index.php
                form enctype: application/x-www-form-urlencoded -> Tells html to send the data in a url encoded format(which is the default)
                
                button name: Create -> Tells html to submit the form with the name "Create"
                button class: create-button -> Tells html to apply the create-button class to the button
                
                button type: submit -> Tells html to submit the form
                (ie tells html that the content of the form is done and ready to be sent to the server)
            -->
            <form method="post" action="index.php" enctype="application/x-www-form-urlencoded">
                <button type="submit" name="Go_To_Create_Account" class="create-button">Create Account</button>
            </form>

            <!--Serves a pourpose :) dont have great words to articulate it right now-->
            <?php
                    if (isset($_SESSION['error']) && !isset($_SESSION['success'])) { 
                        echo '<p class="error" style="color: red;">' . htmlspecialchars($_SESSION['error']) . '</p>'; 
                        unset($_SESSION['error']);
                    } 
                    if (isset($_SESSION['success'])) { 
                        echo '<p class="success" style="color: green;">' . htmlspecialchars($_SESSION['success']) . '</p>'; 
                        unset($_SESSION['success']);
                    }
            ?>
        </div>
    </body>
</html>
