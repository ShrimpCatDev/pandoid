local part={ps={}}

function part.new(x,y,vx,vy,ax,ay,lt,df,kf)
    table.insert(part.ps,{x=x,y=y,vx=vx,vy=vy,ax=ax,ay=ay,df=df,lt=lt,kf=kf})
end

function part.update(dt)
    local dels={}
    for k,p in ipairs(part.ps) do
        p.vx=p.vx+(p.ax*dt)
        p.vy=p.vy+(p.ay*dt)
        p.x=p.x+(p.vx*dt)
        p.y=p.y+(p.vy*dt)
        p.lt=p.lt-dt
        if p.lt<0 then
            table.insert(dels,k)
            if p.kf then p.kf() end
        end
    end
    for i=#dels,1,-1 do
        table.remove(part.ps,dels[i])
    end
end

function part.draw()
    for k,p in ipairs(part.ps) do
        p.df(p.x,p.y,p.lt)
    end
end

function part.clear()
    part.ps={}
end

return part
