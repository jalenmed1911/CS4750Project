<?php
session_start();
require("transferportaldb.php");

// Simple login logic
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['username'])) {
    // In a real app, you would validate credentials against the DB here
    $_SESSION['user'] = $_POST['username'];
    header("Location: dashboard.php");
    exit();
}

// Logout logic
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: index.php");
    exit();
}

// Redirect if already logged in
if (isset($_SESSION['user'])) {
    header("Location: dashboard.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Transfer Portal</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form method="post" action="index.php">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit">Sign In</button>
        </form>
    </div>
</body>
</html>
