class Stripe::Error < Exception
  JSON.mapping({
    code:    String?,
    doc_url: String?,
    message: String?,
    param:   String?,
    type:    String,
  })
end
