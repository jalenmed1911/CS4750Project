<?php
session_start();
require("transferportaldb.php");
require("positionStats.php");

if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit();
}
$username = $_SESSION['user'];
/*
function bandedRandom0to40() {
    const bands = [
        [0, 5, 1],
        [6, 10, 3],
        [11, 15, 6],
        [16, 20, 10],
        [21, 25, 10],
        [26, 30, 6],
        [31, 35, 3],
        [36, 40, 1]
    ];

    // calculate total weight
    let totalWeight = 0;
    for (const band of bands) {
        totalWeight += band[2];
    }

    // pick a random weight slot
    let rand = Math.floor(Math.random() * totalWeight) + 1;

    // find which band it falls into
    let current = 0;
    for (const band of bands) {
        current += band[2];

        if (rand <= current) {
            const min = band[0];
            const max = band[1];

            // return random value within band
            return Math.floor(Math.random() * (max - min + 1)) + min;
        }
    }

    // fallback (should never hit)
    return 20;
}
*/








?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Player Management - Transfer Portal</title>
    <link rel="stylesheet" href="dashboard.css">
    <script>
        
        function randomUpdate() {
            try {
                const btn = document.querySelector('.circular-button');
                
                if (btn.disabled) return; // Already on cooldown
                
                btn.disabled = true;

                //php Fetch to update stats in the database
                fetch("updatePlayerStats.php", {
                    method: "POST",
                    headers: {
                        "X-Requested-With": "XMLHttpRequest"
                    }
                })
                .then(res => res.json())
                .then(data => {
                    window.location.reload();
                    console.log("Update success:", data);
                })
                .catch(err => console.error("Update failed:", err))
                .finally(() => {
                    // Re-enable button after 5 seconds
                    setTimeout(() => {
                        btn.disabled = false;
                    }, 5000);
                });

            } catch (error) {
                console.error("Error updating stats:", error);
            }

        }



    </script>
    <style>
        .circular-button {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background-color: #0066cc;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s ease;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 10;
        }
        
        .circular-button:hover {
            background-color: #0052a3;
        }
        
        .circular-button.clicked {
            transform: translate(-50%, -50%) scale(0.95);
            background-color: #004080;
        }
        
        .circular-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            background-color: #999;
        }
        
        .stats-container {
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 15px;
        }
        
        .stats-box {
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 4px;
            text-align: center;
            font-weight: 600;
            min-height: 100px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .stat-label {
            font-weight: bold;
            margin-bottom: 8px;
        }
        
        .stat-value {
            font-size: 1.2em;
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
                <?php
                if ($_SESSION['role'] == 'admin') {
                    echo "<li><a href='dashboard.php' class='active'>Dashboard</a></li>";
                } else {
                    echo "<li><a href='playerManagement.php'>Dashboard</a></li>";
                }
                ?>
                <li><a href="#">Team Search</a></li>
                <li><a href="manageOffers.php">Manage Offers</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <div class="welcome-header">
                <h1>Player Dashboard</h1>
                <p>Manage your player information.</p>
            </div>
            <section class="activity-section">

                <h2>Player Information</h2>
                <?php
                $userID = $_SESSION['userID'];

                $myPlayer = getUserPlayers($userID);
                $pos_abbr = $myPlayer['position'];
                $config = $positionStats[$pos_abbr];
                $pos_full = $config['table'];
                $statsMap = $config['stats'];

                echo "<div class='player-card'>";
                echo "<h3>" . htmlspecialchars($myPlayer['name']) . "</h3>";
                echo "<p><strong>Position:</strong> " . htmlspecialchars(str_replace('_', ' ', $pos_full)) . "</p>";
                echo "<p><strong>Team:</strong> " . (hasTeam($myPlayer['playerID']) ? htmlspecialchars(getPlayerTeamName($myPlayer['playerID'])['name']) : "Free Agent") . "</p>";
                echo "<p><strong>Valuation:</strong> " . number_format($myPlayer['valuation'], 0, '.', ',') . "</p>";                    
                echo "<p><strong>Stars:</strong> " . number_format($myPlayer['stars'], 0, '.', ',') . "</p>";                    
                echo "</div>";
                ?>
                <?php if (hasTeam($myPlayer['playerID'])): ?>
                <form method="post" action="index.php">
                <button type="submit" name="LeaveTeam" style="margin-top: 20px; background-color: #e11d48; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 4px; cursor: pointer; font-weight: 600;">Leave Team</button>
                </form>
                <?php endif; ?>

                <?php
                $stats = getStatsByPlayer($myPlayer['playerID']);

                if (!$stats) {
                    echo "No stats found.";
                    return;
                }

                $pos = $stats['position']; // "QB", "RB", etc.
                $config = $positionStats[$pos];

                foreach ($config['stats'] as $column => $label) {
                    echo "<p><strong>$label:</strong> " . htmlspecialchars($stats[$column]) . "</p>";
                }
                ?>

            </section>



            
            <section class="activity-section">

                <h2>Player Stats</h2>
                <div class="stats-container">
                    <button class="circular-button" onclick="randomUpdate()">
                        <img src="" alt="Refresh Stats">
                    </button>


                    <div class="stats-grid">
                        <?php
                        $stat_labels = array_values($statsMap);
                        $stat_columns = array_keys($statsMap);
                        for ($i = 0; $i < 4; $i++) {
                            if ($i < count($stat_labels)) {
                                $label = $stat_labels[$i];
                                $column = $stat_columns[$i];
                                $value = isset($stats[$column]) ? $stats[$column] : '-';
                                echo "<div class='stats-box'><div class='stat-label'>" . htmlspecialchars($label) . "</div><div class='stat-value'>" . htmlspecialchars($value) . "</div></div>";
                            } else {
                                echo "<div class='stats-box'>-</div>";
                            }
                        }
                        ?>
                    </div>
                </div>

            </section>
                
        
        </main>
    </div>
</body>
</html>