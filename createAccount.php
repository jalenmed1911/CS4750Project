<?php
session_start();
require("transferportaldb.php");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Transfer Portal</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>
    <div class="login-container">
        <h2>Create A Transfer Portal Account</h2>
        <form method="post" action="index.php">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" name="CreateAccount">Create Account</button>
        </form>
        <form method="post" action="index.php">
        <button type="submit" name="Return" style="margin-top: 10px;">Return to Login</button>
        </form>
        <?php 
        if (isset($_SESSION['error'])) { 
            echo '<p class="error" style="color: red;">' . htmlspecialchars($_SESSION['error']) . '</p>'; 
            unset($_SESSION['error']);
        } 
        ?>
    </div>
</body>
</html>
