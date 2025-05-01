const logBox = document.getElementById('outputLog');
const goalForm = document.getElementById('goalForm');
const goalInput = document.getElementById('goalInput');
const intervalInput = document.getElementById('intervalInput');

goalForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  const goal = goalInput.value;
  const interval = intervalInput.value || 60;

  const goalRes = await fetch('/submit_goal', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ goal, interval })
  });

  const status = await goalRes.text();
  logBox.value += `[GOAL SUBMITTED] ${status}\n`;
});

async function fetchLog() {
  const res = await fetch('/stream_log');
  const data = await res.text();
  logBox.value = data;
}

setInterval(fetchLog, 2000);
