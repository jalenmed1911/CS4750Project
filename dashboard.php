<?php
require("transferportaldb.php");
session_start();

if (!isset($_SESSION['user']) || (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin')) {
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
                <?php
                if ($_SESSION['role'] == 'admin') {
                    echo "<li><a href='dashboard.php' class='active'>Admin Dashboard</a></li>";
                } else {
                    echo "<li><a href='playerManagement.php'>Dashboard</a></li>";
                }
                ?>
                
                <li><a href="teamSearch.php">Team Search</a></li>
                <li><a href="manageOffers.php">Manage Offers</a></li>
            </ul>
        </aside>

                
        <main class="main-content">
            <div class="welcome-header">
                <h1>Admin Dashboard</h1>
                <p>Manage the database system from here.</p>
            </div>
            
            <div class="stats-container">
                <div class="stat-card"><h3>Total Players</h3><div class="value"><?php echo totalPlayers();?></div></div>
                <div class="stat-card"><h3>Open Offers</h3><div class="value"><?php echo totalOffers(); ?></div></div>
                <div class="stat-card"><h3>Avg Valuation</h3><div class="value"><?php echo number_format(getTotalAverageValuation(), 0, '.', ','); ?></div></div>
            </div>
            
            <section class="activity-section">
                <h2>All Open Offers</h2>
                <?php 
                $openOffers = getAllOffersDetailed('Pending');
                if (empty($openOffers)): 
                ?>
                    <div class="placeholder-table">No open offers found in the system.</div>
                <?php else: ?>
                    <div style="overflow-x: auto; margin-top: 1rem;">
                        <table style="width: 100%; border-collapse: collapse; text-align: left;">
                            <thead style="background-color: #f8fafc; border-bottom: 2px solid #edf2f7;">
                                <tr>
                                    <th style="padding: 1rem; color: #64748b; font-size: 0.85rem; text-transform: uppercase;">Player</th>
                                    <th style="padding: 1rem; color: #64748b; font-size: 0.85rem; text-transform: uppercase;">Team</th>
                                    <th style="padding: 1rem; color: #64748b; font-size: 0.85rem; text-transform: uppercase;">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($openOffers as $offer): ?>
                                <tr style="border-bottom: 1px solid #edf2f7;">
                                    <td style="padding: 1rem; font-weight: 500;"><?php echo htmlspecialchars($offer['player_name']); ?></td>
                                    <td style="padding: 1rem;"><?php echo htmlspecialchars($offer['team_name']); ?></td>
                                    <td style="padding: 1rem; color: #059669; font-weight: 600;">$<?php echo number_format($offer['amount'] * 100, 0); ?></td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php endif; ?>
            </section>

            <div class="welcome-header" style="margin-top: 4rem;">
                <h1>Account Management Dashboard</h1>
                <p>Manage the accounts from the database system here.</p>
            </div>

            <?php if (isset($_SESSION['error'])): ?>
                <div style="background: #fee2e2; color: #991b1b; padding: 1rem; border-radius: 6px; margin-bottom: 1.5rem; border: 1px solid #fecaca;">
                    <?php echo htmlspecialchars($_SESSION['error']); unset($_SESSION['error']); ?>
                </div>
            <?php endif; ?>

            <?php if (isset($_SESSION['success'])): ?>
                <div style="background: #ecfdf5; color: #065f46; padding: 1rem; border-radius: 6px; margin-bottom: 1.5rem; border: 1px solid #a7f3d0;">
                    <?php echo htmlspecialchars($_SESSION['success']); unset($_SESSION['success']); ?>
                </div>
            <?php endif; ?>
            
            <div class="stats-container">
                <?php 
                $users = getAllUsers();
                foreach ($users as $user) {
                    echo "<div class='stat-card'>";
                    echo "<h3>" . htmlspecialchars($user['username']) . "</h3>";
                    echo "<div class='value'>Role: " . ($user['isAdmin'] == 1 ? 'Admin' : 'User') . "</div>";

                    if ($user['username'] !== $_SESSION['user']){
                    echo "<form method='post' action='index.php' style='margin-top: 15px;' onsubmit=\"return confirm('Are you sure you want to delete this account? This action cannot be undone.');\">";
                    echo "<input type='hidden' name='userID' value='" . htmlspecialchars($user['userID']) . "'>";
                    echo "<button type='submit' name='deleteUser' style='background-color: #e11d48; color: white; border: none; padding: 0.5rem 1rem; border-radius: 4px; cursor: pointer; font-weight: 600; width: 100%;'>Delete Account</button>";
                    echo "</form>";

                    if ($user['isAdmin'] == 1) {
                        echo "<form method='post' action='index.php' style='margin-top: 10px;' onsubmit=\"return confirm('Are you sure you want to remove admin privileges from this user?');\">";
                        echo "<input type='hidden' name='userID' value='" . htmlspecialchars($user['userID']) . "'>";
                        echo "<button type='submit' name='removeAdmin' style='background-color: #d62e00; color: white; border: none; padding: 0.5rem 1rem; border-radius: 4px; cursor: pointer; font-weight: 600; width: 100%;'>Remove Admin</button>";
                        echo "</form>";
                    }

                    }
                    else{
                        echo "<div style='margin-top: 15px; color: #6b7280; font-size: 0.9rem;'>This is you</div>";
                    }

                    if ($user['isAdmin'] == 0) {
                        echo "<form method='post' action='index.php' style='margin-top: 10px;' onsubmit=\"return confirm('Are you sure you want to make this user an admin?');\">";
                        echo "<input type='hidden' name='userID' value='" . htmlspecialchars($user['userID']) . "'>";
                        echo "<button type='submit' name='makeAdmin' style='background-color: #3498db; color: white; border: none; padding: 0.5rem 1rem; border-radius: 4px; cursor: pointer; font-weight: 600; width: 100%;'>Make Admin</button>";
                        echo "</form>";
                    }

                    echo "</div>";
                }
                ?>
            </div>
            
        </main>

    </div>
</body>
</html>