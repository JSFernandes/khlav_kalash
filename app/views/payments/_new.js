const stripeData = document.getElementById('stripeData')
const orderData = document.getElementById('orderData')
const errorField = document.getElementById('paymentErrors')
const submitButton = document.getElementById('confirmButton')
const submittingButton = document.getElementById('submittingButton')

const stripe = Stripe(stripeData.dataset.publicKey);
const elements = stripe.elements({locale: 'en'});
const cardElement = elements.create('card');
cardElement.mount('#creditCardForm')

const paymentRequest = stripe.paymentRequest(
  {
    country: 'US',
    currency: 'usd',
    total: { label: 'Khlav Kalash', amount: parseInt(orderData.dataset.amount) },
    ...JSON.parse(orderData.dataset.billing),
  }
);
const paymentIntentSecret = stripeData.dataset.intentSecret

document.getElementById('paymentForm').addEventListener('submit', function (event) {
  errorField.style.display = 'none';
  submitButton.style.display = 'none';
  submittingButton.style.display = 'block';

  event.preventDefault();

  stripe
    .confirmCardPayment(paymentIntentSecret, {
      payment_method: {
        card: cardElement
      }
    })
    .then(function(result) {
      if (result.error) {
        errorField.style.display = 'block'
        submitButton.style.display = 'block'
        submittingButton.style.display = 'none'

        errorField.innerHTML = result.error.message
      } else {
        window.location = orderData.dataset.paymentSuccessfulUrl
      }
    });
})
