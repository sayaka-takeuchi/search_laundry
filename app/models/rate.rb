class Rate < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'とても悪い' },
    { id: 2, name: '悪い' },
    { id: 3, name: '普通' },
    { id: 4, name: '良い' },
    { id: 5, name: 'とても良い' }
  ]
end
