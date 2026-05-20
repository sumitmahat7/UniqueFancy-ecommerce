
/**
 * Unique Fancy — Main JavaScript (Cleaned for VIVA)
 */

document.addEventListener('DOMContentLoaded', function() {

    /* ============================================================
       1. MOBILE NAVIGATION TOGGLE (Hamburger Menu)
       ============================================================ */
    const mobileBtn = document.getElementById('mobileMenuBtn');
    const navLinks = document.querySelector('.nav-links');

    if (mobileBtn && navLinks) {
        mobileBtn.addEventListener('click', function() {
            navLinks.classList.toggle('show');
            mobileBtn.innerHTML = navLinks.classList.contains('show') ? '✕' : '☰';
        });

        // Close menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!navLinks.contains(e.target) && !mobileBtn.contains(e.target)) {
                navLinks.classList.remove('show');
                mobileBtn.innerHTML = '☰';
            }
        });
    }

    /* ============================================================
       2. PRODUCT DETAILS - SIZE SELECTOR
       ============================================================ */
    const sizeBtns = document.querySelectorAll('.size-btn:not(:disabled)');
    const sizeInputs = document.querySelectorAll('input[name="size"]');

    sizeBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
            sizeBtns.forEach(function(b) { b.classList.remove('selected'); });
            btn.classList.add('selected');

            const sizeName = btn.getAttribute('data-size') || btn.textContent.trim();
            sizeInputs.forEach(function(inp) {
                inp.value = sizeName;
            });

            const warn = document.getElementById('noSizeWarning');
            if (warn) warn.style.display = 'none';
        });
    });

    /* ============================================================
       3. PRODUCT DETAILS - QUANTITY CONTROLS
       ============================================================ */
    const qtyDisplay = document.getElementById('quantityDisplay');
    const qtyMinus = document.getElementById('qtyMinus');
    const qtyPlus = document.getElementById('qtyPlus');
    const quantityInputs = document.querySelectorAll('input[name="quantity"]');

    if (qtyDisplay) {
        let maxStock = parseInt(qtyDisplay.getAttribute('data-max') || '99', 10);
        let currentQty = 1;

        function updateQuantity() {
            qtyDisplay.value = currentQty;
            quantityInputs.forEach(function(inp) {
                inp.value = currentQty;
            });
            if (qtyMinus) qtyMinus.disabled = (currentQty <= 1);
            if (qtyPlus) qtyPlus.disabled = (currentQty >= maxStock);
        }

        if (qtyMinus) {
            qtyMinus.addEventListener('click', function() {
                if (currentQty > 1) { currentQty--; updateQuantity(); }
            });
        }

        if (qtyPlus) {
            qtyPlus.addEventListener('click', function() {
                if (currentQty < maxStock) { currentQty++; updateQuantity(); }
            });
        }

        qtyDisplay.addEventListener('change', function() {
            let val = parseInt(qtyDisplay.value, 10);
            if (isNaN(val) || val < 1) val = 1;
            if (val > maxStock) val = maxStock;
            currentQty = val;
            updateQuantity();
        });

        updateQuantity();
    }

    /* ============================================================
       4. ADD TO CART & BUY NOW - SIZE CHECK
       ============================================================ */
    function checkSizeAndSubmit(form) {
        const sizeInput = form.querySelector('input[name="size"]');
        if (!sizeInput || !sizeInput.value.trim()) {
            const warn = document.getElementById('noSizeWarning');
            if (warn) {
                warn.style.display = 'block';
                warn.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            }
            return false;
        }
        form.submit();
        return true;
    }

    const addToCartBtn = document.getElementById('addToCartBtn');
    const buyNowBtn = document.getElementById('buyNowBtn');
    const cartForm = document.getElementById('cartForm');
    const buyNowForm = document.getElementById('buyNowForm');

    if (addToCartBtn && cartForm) {
        addToCartBtn.addEventListener('click', function() {
            checkSizeAndSubmit(cartForm);
        });
    }

    if (buyNowBtn && buyNowForm) {
        buyNowBtn.addEventListener('click', function() {
            checkSizeAndSubmit(buyNowForm);
        });
    }

    /* ============================================================
       5. REGISTRATION FORM VALIDATION
       ============================================================ */
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            let errors = [];

            const fullName = document.getElementById('fullName');
            const email = document.getElementById('email');
            const phone = document.getElementById('phone');
            const password = document.getElementById('password');
            const confirm = document.getElementById('confirmPassword');

            document.querySelectorAll('.field-error').forEach(el => el.remove());

            if (!fullName || fullName.value.trim().length < 2 || !/^[A-Za-z\s]+$/.test(fullName.value.trim())) {
                showError(fullName, 'Name must be 2+ characters (letters only)');
                errors.push('name');
            }

            if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value.trim())) {
                showError(email, 'Enter a valid email address');
                errors.push('email');
            }

            if (!phone || !/^\d{10,15}$/.test(phone.value.trim())) {
                showError(phone, 'Phone must be 10-15 digits');
                errors.push('phone');
            }

            if (!password || password.value.length < 6) {
                showError(password, 'Password must be at least 6 characters');
                errors.push('password');
            }

            if (confirm && password && confirm.value !== password.value) {
                showError(confirm, 'Passwords do not match');
                errors.push('confirm');
            }

            if (errors.length > 0) {
                e.preventDefault();
                const firstError = document.querySelector('.field-error');
                if (firstError) firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });
    }

    function showError(field, message) {
        if (!field) return;
        field.style.borderColor = '#c0392b';
        const errorDiv = document.createElement('div');
        errorDiv.className = 'field-error';
        errorDiv.textContent = '⚠ ' + message;
        errorDiv.style.cssText = 'color:#c0392b;font-size:0.8rem;margin-top:4px;';
        field.parentNode.appendChild(errorDiv);
    }

    /* ============================================================
       6. DELETE CONFIRMATION
       ============================================================ */
    document.querySelectorAll('.delete-confirm, .btn-danger, [data-confirm]').forEach(function(el) {
        el.addEventListener('click', function(e) {
            const message = el.getAttribute('data-confirm') || 'Are you sure? This cannot be undone.';
            if (!confirm(message)) {
                e.preventDefault();
            }
        });
    });

    /* ============================================================
       7. CLEAR CART CONFIRMATION
       ============================================================ */
    const clearCartBtn = document.getElementById('clearCartBtn');
    if (clearCartBtn) {
        clearCartBtn.addEventListener('click', function(e) {
            if (!confirm('Remove all items from your cart?')) {
                e.preventDefault();
            }
        });
    }

    /* ============================================================
       8. CHECKOUT FORM VALIDATION
       ============================================================ */
    const checkoutForm = document.getElementById('checkoutForm');
    if (checkoutForm) {
        checkoutForm.addEventListener('submit', function(e) {
            let errors = [];

            const address = document.getElementById('shippingAddress');
            const payment = document.querySelector('input[name="paymentMethod"]:checked');

            document.querySelectorAll('.field-error').forEach(el => el.remove());

            if (!address || address.value.trim().length < 5) {
                showError(address, 'Enter a valid shipping address (min 5 characters)');
                errors.push('address');
            }

            if (!payment) {
                const paymentSection = document.getElementById('paymentSection');
                if (paymentSection) {
                    const errorMsg = document.createElement('div');
                    errorMsg.className = 'field-error';
                    errorMsg.textContent = '⚠ Please select a payment method';
                    errorMsg.style.cssText = 'color:#c0392b;font-size:0.8rem;margin-top:8px;';
                    paymentSection.appendChild(errorMsg);
                }
                errors.push('payment');
            }

            if (errors.length > 0) {
                e.preventDefault();
                const firstError = document.querySelector('.field-error');
                if (firstError) firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });
    }

    /* ============================================================
       9. NEWSLETTER SUBSCRIBE (Demo)
       ============================================================ */
    const newsletterForm = document.querySelector('.newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const emailInput = this.querySelector('input[type="email"]');
            if (emailInput && emailInput.value.trim()) {
                alert('Thank you for subscribing!');
                emailInput.value = '';
            } else {
                alert('Please enter a valid email address.');
            }
        });
    }

    /* ============================================================
       10. BACK TO TOP BUTTON
       ============================================================ */
    const backToTop = document.getElementById('backToTop');
    if (backToTop) {
        window.addEventListener('scroll', function() {
            backToTop.style.display = window.scrollY > 400 ? 'flex' : 'none';
        });

        backToTop.addEventListener('click', function() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    /* ============================================================
       11. ACTIVE NAVIGATION LINK HIGHLIGHT
       ============================================================ */
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-links a').forEach(function(link) {
        const href = link.getAttribute('href');
        if (href && currentPath.includes(href) && href !== '/') {
            link.classList.add('active');
        }
    });
});