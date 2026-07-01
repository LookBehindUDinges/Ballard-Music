document.addEventListener('DOMContentLoaded', () => {
  const toggle = document.querySelector('.nav-toggle');
  const nav = document.querySelector('nav.main-nav');
  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      const open = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', String(open));
    });
  }

  const commissionForm = document.getElementById('commissionForm');
  if (commissionForm) {
    commissionForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const name = document.getElementById('commName').value.trim();
      const email = document.getElementById('commEmail').value.trim();
      const type = document.getElementById('commType').value;
      const details = document.getElementById('commDetails').value.trim();

      const subject = encodeURIComponent(`Commission request: ${type}`);
      const body = encodeURIComponent(
        `Name: ${name}\nEmail: ${email}\nType: ${type}\n\n${details}`
      );
      window.location.href = `mailto:benballard122@gmail.com?subject=${subject}&body=${body}`;
    });
  }
});
