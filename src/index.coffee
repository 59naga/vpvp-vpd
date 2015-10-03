# Dependencies
iconv= require 'iconv-lite'

# Public
class VpvpVpd
  parse: (buffer)->
    raw= (iconv.decode buffer,'shift_jis').toString().replace /\r\n/g,'\n'
    beginBonePosition= raw.indexOf 'Bone'

    header=
      raw.slice 0,beginBonePosition
      .trim()
      .split /\n/
      .filter (line)-> line.length
      .map (line)-> line.replace /\s/g,''

    chunks=
      raw.slice beginBonePosition
      .split '}'

    bones=
      for chunk in chunks
        [head,positionLine,quaternionLine]= chunk.trim().split /\n/,3
        [id,name]= head.split '{'

        continue unless name

        [position]= positionLine.trim().split ';'
        position= position.split(',').map (vector)-> parseFloat vector

        [quaternion]= quaternionLine.trim().split ';'
        quaternion= quaternion.split(',').map (vector)-> parseFloat vector

        {id,name,position,quaternion}

    {header,bones}

module.exports= new VpvpVpd
module.exports.VpvpVpd= VpvpVpd
