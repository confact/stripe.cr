require "spec"
require "webmock"
Spec.before_each &->WebMock.reset
Spec.before_each { Stripe.api_key = "test" }
require "../src/stripe"
