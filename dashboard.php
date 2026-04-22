<?php
require("transferportaldb.php");
session_start();

if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Transfer Portal</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <nav class="top-nav">
        <div class="brand">Fantasy Football Portal</div>
        <div class="user-menu">
            <span>Welcome, <a href="profile.php" style="text-decoration: none; color: inherit;"><strong><?php echo htmlspecialchars($_SESSION['user']); ?></strong></a></span>
            <a href="index.php?logout=1" class="logout-link">Logout</a>
        </div>
    </nav>
    
    <div class="dashboard-wrapper">
        <aside class="sidebar">
            <ul class="nav-links">
                <li><a href="dashboard.php" class="active">Dashboard Overview</a></li>
                <li><a href="playerManagement.php">Player Management</a></li>
                <li><a href="#">Team Search</a></li>
                <li><a href="manageOffers.php">Manage Offers</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <div class="welcome-header">
                <h1>System Dashboard</h1>
                <p>Manage your roster and player valuations from here.</p>
            </div>
            
            <div class="stats-container">
                <div class="stat-card"><h3>Total Players</h3><div class="value"><?php echo totalPlayers();?></div></div>
                <div class="stat-card"><h3>Open Offers</h3><div class="value"><?php echo totalOffers(); ?></div></div>
                <div class="stat-card"><h3>Avg Valuation</h3><div class="value"><?php echo number_format(getTotalAverageValuation(), 0, '.', ','); ?></div></div>
            </div>
            
            <section class="activity-section">
                <h2>Recent Activity</h2>
                <div class="placeholder-table">No recent transfers recorded today.</div>
            </section>
        </main>
    </div>
</body>
</html>