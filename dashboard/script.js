// script.js
// Mock data representing what the shell scripts would output to a JSON file or DB

const dashboardData = {
    metrics: {
        totalLogs: 1542,
        warnings: 34,
        errors: 12,
        critical: 3
    },
    rcaSuggestions: [
        "[09:05:20] DATABASE OUTAGE DETECTED: Check primary DB instance health, network connectivity, and connection pool limits.",
        "[10:05:22] APPLICATION CRASH DETECTED: Java OutOfMemoryError found. Investigate memory leaks or increase JVM heap size.",
        "[14:12:00] PAYMENT GATEWAY TIMEOUTS: Verify external API vendor status and check firewall/proxy rules.",
        "[11:30:15] MISSING RECORDS: Discrepancy in transaction reconciliation. Audit the message queue or DB transaction commits."
    ],
    timelineData: {
        labels: ['08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00'],
        errors: [1, 2, 5, 1, 0, 2, 3, 1, 2]
    }
};

// Animation function for counting up numbers smoothly
function animateValue(obj, start, end, duration) {
    let startTimestamp = null;
    const step = (timestamp) => {
        if (!startTimestamp) startTimestamp = timestamp;
        const progress = Math.min((timestamp - startTimestamp) / duration, 1);
        
        // Easing function (easeOutQuart)
        const easeProgress = 1 - Math.pow(1 - progress, 4);
        
        obj.innerHTML = Math.floor(easeProgress * (end - start) + start);
        if (progress < 1) {
            window.requestAnimationFrame(step);
        }
    };
    window.requestAnimationFrame(step);
}

// Initialize Dashboard
document.addEventListener('DOMContentLoaded', () => {
    // 1. Populate Metrics with animation
    animateValue(document.getElementById('totalLogs'), 0, dashboardData.metrics.totalLogs, 2000);
    animateValue(document.getElementById('totalWarnings'), 0, dashboardData.metrics.warnings, 2000);
    animateValue(document.getElementById('totalErrors'), 0, dashboardData.metrics.errors, 2000);
    animateValue(document.getElementById('totalCritical'), 0, dashboardData.metrics.critical, 2000);

    // 2. Populate RCA List
    const rcaList = document.getElementById('rcaList');
    dashboardData.rcaSuggestions.forEach((suggestion, index) => {
        const li = document.createElement('li');
        li.textContent = suggestion;
        
        // Add a subtle stagger animation effect via inline delay
        li.style.opacity = '0';
        li.style.transform = 'translateY(10px)';
        li.style.transition = 'all 0.5s ease';
        li.style.transitionDelay = `${0.8 + (index * 0.1)}s`;
        
        rcaList.appendChild(li);
        
        // Trigger reflow and apply visible state
        setTimeout(() => {
            li.style.opacity = '1';
            li.style.transform = 'translateY(0)';
        }, 10);
    });

    // 3. Initialize Charts (Chart.js)
    Chart.defaults.color = '#8b92a5';
    Chart.defaults.font.family = "'Outfit', sans-serif";
    Chart.defaults.plugins.tooltip.backgroundColor = 'rgba(20, 22, 30, 0.9)';
    Chart.defaults.plugins.tooltip.titleFont = { size: 14, family: 'Outfit', weight: 'bold' };
    Chart.defaults.plugins.tooltip.padding = 12;
    Chart.defaults.plugins.tooltip.cornerRadius = 8;
    Chart.defaults.plugins.tooltip.borderColor = 'rgba(255,255,255,0.1)';
    Chart.defaults.plugins.tooltip.borderWidth = 1;

    // Severity Doughnut Chart
    const severityCtx = document.getElementById('severityChart').getContext('2d');
    new Chart(severityCtx, {
        type: 'doughnut',
        data: {
            labels: ['Warnings', 'Errors', 'Critical'],
            datasets: [{
                data: [
                    dashboardData.metrics.warnings, 
                    dashboardData.metrics.errors, 
                    dashboardData.metrics.critical
                ],
                backgroundColor: [
                    '#ffb703', // warning
                    '#ff3366', // error
                    '#8e24aa'  // critical
                ],
                borderWidth: 2,
                borderColor: '#14161e',
                hoverOffset: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { 
                    position: 'bottom',
                    labels: { padding: 20, usePointStyle: true, pointStyle: 'circle' }
                }
            },
            cutout: '75%',
            animation: {
                animateScale: true,
                animateRotate: true,
                duration: 2000,
                easing: 'easeOutQuart'
            }
        }
    });

    // Timeline Line Chart
    const timelineCtx = document.getElementById('timelineChart').getContext('2d');
    
    // Create gradient fill for line chart
    const gradientFill = timelineCtx.createLinearGradient(0, 0, 0, 400);
    gradientFill.addColorStop(0, 'rgba(0, 210, 255, 0.4)');
    gradientFill.addColorStop(1, 'rgba(0, 210, 255, 0.0)');

    new Chart(timelineCtx, {
        type: 'line',
        data: {
            labels: dashboardData.timelineData.labels,
            datasets: [{
                label: 'Errors Encountered',
                data: dashboardData.timelineData.errors,
                borderColor: '#00d2ff',
                backgroundColor: gradientFill,
                borderWidth: 3,
                tension: 0.4, // Smooth curves
                fill: true,
                pointBackgroundColor: '#050505',
                pointBorderColor: '#00d2ff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7,
                pointHoverBackgroundColor: '#00d2ff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(255,255,255,0.03)', drawBorder: false },
                    border: { display: false }
                },
                x: {
                    grid: { display: false },
                    border: { display: false }
                }
            },
            plugins: {
                legend: { display: false }
            },
            interaction: {
                mode: 'index',
                intersect: false,
            },
            animation: {
                duration: 2000,
                easing: 'easeOutQuart'
            }
        }
    });
});
