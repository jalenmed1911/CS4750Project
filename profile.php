<?php
session_start();
require("transferportaldb.php");

if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit();
}

$username = $_SESSION['user'];
$playerData = null;
$playerStats = null;
$playerTeamName = null;

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Transfer Portal</title>
    <link rel="stylesheet" href="dashboard.css"> <!-- Reusing dashboard.css for consistency -->
    <style>
        .profile-container {
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .profile-container h2 {
            color: #333;
            margin-bottom: 15px;
        }
        .profile-info p {
            margin-bottom: 8px;
            font-size: 1.1em;
        }
        .profile-info strong {
            color: #555;
        }
        .stat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .stat-item {
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #eee;
        }
        .stat-item strong {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
    </style>
</head>
<body>
    <nav class="top-nav">
        <div class="brand">Fantasy Football Portal</div>
        <div class="user-menu">
            <span>Welcome, <a href="profile.php" style="text-decoration: none; color: inherit;"><strong><?php echo htmlspecialchars($username); ?></strong></a></span>
            <a href="index.php?logout=1" class="logout-link">Logout</a>
        </div>
    </nav>
    
    <div class="dashboard-wrapper">
        <aside class="sidebar">
            <ul class="nav-links">
                <li><a href="dashboard.php">Dashboard Overview</a></li>
                <li><a href="playerManagement.php">Player Management</a></li>
                <li><a href="#">Team Management</a></li>
                <li><a href="#">Recruitment Offers</a></li>
                <li><a href="manageOffers.php">Manage Offers</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <div class="welcome-header">
                <h1>User Profile</h1>
                <p>View your account and associated player details.</p>
            </div>
            
            <div class="profile-container">
                <h2>Account Information</h2>
                <div class="profile-info">
                    <p><strong>Username:</strong> <?php echo htmlspecialchars($username); ?></p>
                </div>

                <?php if ($playerData): ?>
                    <h2>Player Information</h2>
                    <div class="profile-info">
                        <p><strong>Player Name:</strong> <?php echo htmlspecialchars($playerData['name']); ?></p>
                        <p><strong>Position:</strong> <?php echo htmlspecialchars($playerData['position']); ?></p>
                        <p><strong>Hometown:</strong> <?php echo htmlspecialchars($playerData['hometown']); ?></p>
                        <p><strong>Valuation:</strong> $<?php echo number_format($playerData['valuation'], 0, '.', ','); ?></p>
                        <p><strong>Stars:</strong> <?php echo htmlspecialchars($playerData['stars']); ?></p>
                        <?php if ($playerTeamName): ?>
                            <p><strong>Team:</strong> <?php echo htmlspecialchars($playerTeamName['name']); ?></p>
                        <?php endif; ?>
                    </div>

                    <?php if ($playerStats): ?>
                        <h3>Player Stats (<?php echo htmlspecialchars($playerData['position']); ?>)</h3>
                        <div class="stat-grid">
                            <?php foreach ($playerStats as $key => $value): ?>
                                <?php if ($key !== 'playerID' && $key !== 'position'): ?>
                                    <div class="stat-item">
                                        <strong><?php echo htmlspecialchars(ucwords(str_replace('_', ' ', $key))); ?>:</strong> <?php echo htmlspecialchars($value); ?>
                                    </div>
                                <?php endif; ?>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
                <?php else: ?>
                    <p>You are not currently associated with a player profile. Please contact support if this is incorrect.</p>
                <?php endif; ?>
            </div>
            <form method="post" action="index.php">
                <button type="submit" name="Delete" style="margin-top: 20px; background-color: #e11d48; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 4px; cursor: pointer; font-weight: 600;">Delete Account</button>
            </form>
        </main>
    </div>
</body>
</html>