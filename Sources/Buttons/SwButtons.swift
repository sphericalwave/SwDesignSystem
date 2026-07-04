//
//  SwButtons.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2024-07-13.
//  Copyright © 2024 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct TrashBtn: View {
    
    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }
    
    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "trash.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red1)
                .frame(width: 33, height: 33)
        }
    }
}

@available(iOS 13.0, *)
public struct DownBtn: View {
    
    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }
    
    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "arrow.down.square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red1)
                .frame(width: 33, height: 33)
        }
    }
}

@available(iOS 13.0, *)
public struct PlusBtn2: View {

    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }

    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "plus.app")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.tint)
                .frame(width: 33, height: 33)
        }
    }
}


@available(iOS 13.0, *)
public struct CheckMarkBtn: View {
    
    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }
    
    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "checkmark.square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue1)
                .frame(width: 33, height: 33)
        }
    }
}


@available(iOS 13.0, *)
public struct UndoBtn: View {
    
    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }
    
    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "arrow.uturn.backward.square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red1)
                .frame(width: 33, height: 33)
        }
    }
}

@available(iOS 13.0, *)
public struct BackBtn: View {
    
    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }
    
    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "arrow.backward.square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.primary)
                .frame(width: 33, height: 33)
        }
    }
}

@available(iOS 13.0, *)
public struct SaveBtn2: View {
    
    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }
    
    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.primary)
                .frame(width: 33, height: 33)
        }
        //.background(Color.gray)
    }
}

@available(iOS 13.0, *)
public struct TargetBtn: View {
    
    public init(didTap: ( () -> Void)?) {
        self.didTap = didTap
    }
    
    public var didTap: (() -> Void)?

    public var body: some View {
        Button(action: { didTap?() }) {
            Image(systemName: "scope")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 33, height: 33)
        }
    }
}

@available(iOS 13.0, *)
public struct SwBtn_Previews: PreviewProvider {

    public static var previews: some View {
        //Container(selectedPrice: nil)
        HStack {
            TrashBtn(){}
            DownBtn(){}
            PlusBtn2(){}
            CheckMarkBtn(){}
            UndoBtn(){}
            BackBtn(){}
            SaveBtn2(){}
            TargetBtn(){}
        }
    }
}
