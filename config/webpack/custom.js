/* eslint-disable no-undef */
const path = require('path')

module.exports = {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, '..', '..', 'app/javascript'),
      '@apis': path.resolve(__dirname, '..', '..', 'app/javascript/apis'),
      '@pages': path.resolve(__dirname, '..', '..', 'app/javascript/pages'),
      '@themes': path.resolve(__dirname, '..', '..', 'app/javascript/themes'),
      '@helpers': path.resolve(__dirname, '..', '..', 'app/javascript/helpers'),
      '@plugins': path.resolve(__dirname, '..', '..', 'app/javascript/plugins'),
      '@configs': path.resolve(__dirname, '..', '..', 'app/javascript/configs'),
      '@controllers': path.resolve(__dirname, '..', '..', 'app/javascript/controllers')
    }
  }
}
